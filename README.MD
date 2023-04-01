## Ruby-OpenAI-CLI

A tool to query OpenAI's GPT APIs from the command line.

To run the tool, you need an API key from OpenAI, you can get one here:
https://platform.openai.com/account/api-keys
You will be asked to provide on first use of `ruby-openai-cli`, or you can
provide it as `OPENAI_API_KEY` in your environment.

### Development

* Install dependencies: `gem install ruby-openai optparse tty-markdown`
* Build Rubygem: `gem build ruby-openai-cli.gemspec`
