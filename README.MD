[![Gem Version](https://badge.fury.io/rb/ruby-openai-cli.svg)](https://badge.fury.io/rb/ruby-openai-cli)
[![Container build](https://github.com/digitaltom/ruby-openai-cli/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/digitaltom/ruby-openai-cli/pkgs/container/ruby-openai-cli)

## Ruby-OpenAI-CLI

A tool to query OpenAI's GPT APIs from the command line.

### Usage

To run the tool, you need an API key from OpenAI, you can get one here:
https://platform.openai.com/account/api-keys
You will be asked to provide on first use of `ruby-openai-cli`, or you can
provide it as `OPENAI_API_KEY` in your environment.

#### Rubygem

To install the gem, run: `gem install ruby-openai-cli`. Then you can 
use the tool by calling `ruby-openai-cli` on your command line.

#### Container

You can also run the tool from a container without installing it:

`docker run -ti --rm -v ~/.config/ruby-openai-cli:/root/.config/ruby-openai-cli ghcr.io/digitaltom/ruby-openai-cli:main ruby-openai-cli -c`


![image](https://user-images.githubusercontent.com/582520/229295020-e8aa962c-6a87-45e2-802a-c8d41026a56d.png)

### Development

* Install dev dependencies: `gem install awesome_print byebug rubocop`
* Build Rubygem: `gem build ruby-openai-cli.gemspec`
* Build container image: `docker build -t ghcr.io/digitaltom/ruby-openai-cli .`
