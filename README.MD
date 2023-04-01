[![Gem Version](https://badge.fury.io/rb/ruby-openai-cli.svg)](https://badge.fury.io/rb/ruby-openai-cli)

## Ruby-OpenAI-CLI

A tool to query OpenAI's GPT APIs from the command line.

### Usage

To run the tool, you need an API key from OpenAI, you can get one here:
https://platform.openai.com/account/api-keys
You will be asked to provide on first use of `ruby-openai-cli`, or you can
provide it as `OPENAI_API_KEY` in your environment.

To install the gem, run: `gem install ruby-openai-cli`. Then you can 
use the tool by calling `ruby-openai-cli` on your command line.

![image](https://user-images.githubusercontent.com/582520/229295020-e8aa962c-6a87-45e2-802a-c8d41026a56d.png)

### Development

* Install dependencies: `gem install ruby-openai optparse tty-markdown`
* Build Rubygem: `gem build ruby-openai-cli.gemspec`
* Publish Rubygem: `gem push ruby-openai-cli-1.0.gem`
