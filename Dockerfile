FROM alpine:edge

LABEL maintainer="David Anguita <david@davidanguita.name>" version="1.1"

ENV LANG=C.UTF-8
ENV DOTFILES=/dotfiles
ENV WORKSPACE=/workspace
ENV SHELL=/bin/zsh
ENV EDITOR=nvim

RUN apk add --update --no-cache \
      tzdata \
      curl \
      git \
      ncurses \
      tig \
      jq \
      zsh \
      tmux \
      ctags \
      ruby \
      ruby-rake \
      ruby-json \
      ruby-rdoc \
      ruby-irb \
      neovim \
      vim \
      fzf \
      nodejs \
      npm \
      the_silver_searcher

RUN set -ex \
      && apk add --update --no-cache --virtual .build-deps build-base ruby-dev zlib-dev \
      && gem install solargraph bundler bundler:1.17.2 \
      && apk del .build-deps

ARG CACHEBUST=1
RUN git clone --depth 1 https://github.com/danguita/dotfiles.git $DOTFILES \
      && cd $DOTFILES \
      && rake install

WORKDIR $WORKSPACE

CMD $SHELL
