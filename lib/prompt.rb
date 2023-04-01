require 'openai'
require 'byebug'
require 'awesome_print'
require 'dotenv/load'
require 'optparse'
require 'tty-markdown' # https://github.com/piotrmurach/tty-markdown
require_relative 'context'
require_relative 'version'

CONFIG_DIR = Dir.home + '/.config/ruby-openai-cli'
CHATS_DIR = CONFIG_DIR + '/chats'
API_KEY_FILE = CONFIG_DIR + '/api_key'
CONTEXTS_FILE = CONFIG_DIR + '/contexts.json'

MODEL = 'gpt-3.5-turbo'

options = {}
bin_name = File.basename($0)
OptionParser.new do |opts|
  opts.banner = "#{bin_name}, version: #{VERSION}. Usage: #{bin_name} [options]"
  opts.on('-q', '--question QUESTION', 'Provide question as parameter and receive answer to stdout') do |v|
    options[:q] = v
  end
  opts.on('--context CONTEXT', 'Use a context') { |v| options[:context] = v }
  opts.on('--list-contexts', 'List available contexts') { |_v| options[:lc] = true }
  opts.on('-d', '--debug', 'Debug mode') { |_v| options[:d] = true }
  opts.on('-c', '--chat [NAME]', 'Start an interactive conversation (saved as NAME). ' \
                                 'You can continue a previous chat by providing the same name') do |name|
    options[:chat] = true
    FileUtils.mkdir_p(CHATS_DIR) if name
    options[:chat_name] = name
    options[:chat_file] = CHATS_DIR + "/#{name}.json"
  end
  opts.on('-l', '--list-chats', 'List stored chats') { |_v| options[:l] = true }
end.parse!

unless ENV.fetch('OPENAI_API_KEY', nil)
  unless File.exist?(API_KEY_FILE)
    puts 'To use the OpenAI API, you need to get API key at https://platform.openai.com/account/api-keys.'
    puts "It will get stored at #{API_KEY_FILE}."
    puts 'Please enter your API key:'
    FileUtils.mkdir_p(CONFIG_DIR)
    key = gets.chomp
    test_response = OpenAI::Client.new(access_token: key).models.list
    unless test_response.code == 200
      puts test_response['error']['message']
      exit 1
    end
    File.write(API_KEY_FILE, key)
  end
  ENV['OPENAI_API_KEY'] = File.read(API_KEY_FILE)
end

OpenAI.configure do |config|
  config.access_token = ENV.fetch('OPENAI_API_KEY')
  config.request_timeout = 240
end

prompt = ''
client = OpenAI::Client.new

def get_input
  printf TTY::Markdown.parse('**Your message>**', theme: { strong: %i[yellow bold] })
  gets.chomp
end

def format_input(input)
  puts TTY::Markdown.parse("**Your message>**\n" + input + "\n",
                           theme: { strong: %i[yellow bold] })
end

def format_response(response)
  puts TTY::Markdown.parse("\n**ChatGPT response:**\n" + response + "\n\n",
                           theme: { strong: %i[blue bold] })
end

if options[:lc]
  puts 'Available contexts: '
  DEFAULT_CONTEXTS.keys.each do |ctx|
    puts ctx
  end
  exit
end

if options[:l]
  out = "**Available chats:**\n\n"
  Dir[CHATS_DIR + '/*'].each do |file|
    out += "* '#{File.basename(file, '.json')}'\n"
  end
  out += "\nYou can continue a chat with: `#{bin_name} -c '<chat name>'`"
  puts TTY::Markdown.parse(out)
  exit
end

messages_history = []
if options[:chat_name] && File.exist?(options[:chat_file])
  messages_history = JSON.parse(File.read(options[:chat_file]))
  messages_history.each do |message|
    format_input(message['content']) if message['role'] == 'user'
    format_response(message['content']) if message['role'] == 'assistant'
  end
end

if options[:context]
  context = DEFAULT_CONTEXTS[options[:context].to_sym] || options[:context]
  messages_history << { role: 'system', content: context }
end

begin
  loop do
    prompt = options[:q]
    prompt = get_input unless options[:q]
    options[:q] = nil
    messages_history << { "role": 'user', "content": prompt }
    parameters = {
      model: MODEL,
      messages: messages_history,
      temperature: 0.3, # low temperature = very high probability response (0 to 1)
      max_tokens: 2000
    }
    puts "Sending: #{parameters}" if options[:d]
    response = client.chat(parameters:)
    puts "Received: #{response}" if options[:d]
    begin
      response_text = response['choices'][0]['message']['content']
      if options[:chat]
        format_response response_text
      else
        puts response_text
      end
      messages_history << { "role": 'assistant', "content": response_text }
      File.write(options[:chat_file], messages_history.to_json) if options[:chat_name]
    rescue StandardError
      puts "Error: '#{response['error']['message']}'"
    end
    break unless options[:chat]
  end
rescue Interrupt
  puts "Your current chat was saved as '#{options[:chat_name]}' at #{options[:chat_file]}" if options[:chat_name]
  exit 1
end
