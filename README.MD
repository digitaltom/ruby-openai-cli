[![Gem Version](https://badge.fury.io/rb/ruby-openai-cli.svg)](https://badge.fury.io/rb/ruby-openai-cli)

## Ruby-OpenAI-CLI

A tool to query OpenAI's GPT APIs from the command line.

To run the tool, you need an API key from OpenAI, you can get one here:
https://platform.openai.com/account/api-keys
You will be asked to provide on first use of `ruby-openai-cli`, or you can
provide it as `OPENAI_API_KEY` in your environment.

![image](https://user-images.githubusercontent.com/582520/229294457-81542496-1401-450e-a6e2-279dc7de27d3.png)

### Development

* Install dependencies: `gem install ruby-openai optparse tty-markdown`
* Build Rubygem: `gem build ruby-openai-cli.gemspec`
