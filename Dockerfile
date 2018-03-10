FROM ubuntu:16.04

LABEL maintainer="David Anguita <david@davidanguita.name>"
LABEL version="1.0"

# Build-time config
ARG TMUX_VERSION=2.6

# Environmental config
ENV LANG=C.UTF-8
ENV SHELL=/usr/bin/zsh
ENV EDITOR=vim
ENV DOTFILES=/dotfiles
ENV WORKSPACE=/workspace

# Set up locales
RUN apt-get update \
      && apt-get install -y --no-install-recommends locales \
      && locale-gen en_US.UTF-8

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      apt-utils \
      build-essential \
      automake \
      autoconf \
      pkgconf \
      software-properties-common \
      iputils-ping \
      libncurses5-dev \
      libevent-dev \
      net-tools \
      netcat-openbsd \
      tzdata \
      rubygems \
      ruby-dev

# Install common tools
RUN apt-get update && apt-get install -y --no-install-recommends \
      ssh \
      curl \
      wget \
      git \
      tig \
      jq \
      silversearcher-ag \
      zsh \
      tmux \
      xsel

# Install universal-ctags
WORKDIR /usr/local/src
RUN git clone --depth 1 https://github.com/universal-ctags/ctags.git ctags
RUN cd ctags \
      && ./autogen.sh \
      && ./configure \
      && make \
      && make install
RUN rm -rf ctags

# Install vim
RUN add-apt-repository ppa:jonathonf/vim \
      && apt-get update \
      && apt-get install -y --no-install-recommends vim

# Install go
RUN add-apt-repository ppa:longsleep/golang-backports \
      && apt-get update \
      && apt-get install -y --no-install-recommends golang-1.8-go

# Install NodeJS
RUN apt-get update \
      && apt-get install -y --no-install-recommends nodejs npm

# Install tmux
WORKDIR /usr/local/src
RUN wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz \
      && tar xzf tmux-${TMUX_VERSION}.tar.gz
RUN cd tmux-${TMUX_VERSION} \
      && ./configure \
      && make \
      && make install
RUN rm tmux-${TMUX_VERSION}.tar.gz && rm -rf tmux-${TMUX_VERSION}

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf \
      && ~/.fzf/install --completion --key-bindings --no-update-rc

# Set up workspace
ARG CACHEBUST=1
RUN git clone --depth 1 https://github.com/danguita/dotfiles.git $DOTFILES \
      && cd $DOTFILES \
      && rake install

WORKDIR $WORKSPACE
CMD $SHELL
