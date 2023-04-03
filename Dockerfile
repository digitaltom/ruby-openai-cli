FROM symbols/minimal-ruby:latest

WORKDIR /ruby-openai-cli
COPY . /ruby-openai-cli

RUN echo 'gem: --no-document' >> ~/.gemrc
RUN gem build ruby-openai-cli.gemspec
RUN gem install ruby-openai-cli-*.gem

CMD ["ruby-openai-cli"]
