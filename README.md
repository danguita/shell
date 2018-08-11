# danguita's shell

## Motivation

The motivation behind this is to enable building a lightweight and highly
portable development environment with all configuration and tooling I
need in a daily basis.

For instance, the current configuration provides the following setup:

- `zsh` shell.
- `tmux` window manager.
- `vim` editor.
- `git`, `curl`, `fzf`, `jq` and some other tools.
- My [dotfiles](https://github.com/danguita/dotfiles).

It is now based on [Alpine Linux](https://alpinelinux.org/)'s edge branch
for minimal footprint and extra package support.

## Usage

### Build

```shell
$ DOCKER_IMAGE_NAME=danguita/shell DOCKER_IMAGE_TAG=latest make build
```

### Run

```shell
$ DOCKER_IMAGE_NAME=danguita/shell DOCKER_IMAGE_TAG=latest make run
```

Which transforms into:

```shell
$ docker run -it --rm \
  --net=host \                             # Use host networking, optionally.
  -v "$(pwd):/workspace" \                 # Mount `pwd` at container's `/workspace`.
  -v "$HOME/.ssh:/root/.ssh" \             # Mount SSH config, optionally.
  -v "$HOME/.gnupg:/root/.gnupg" \         # Mount GPG config, optionally.
  -v "$HOME/.gitconfig:/root/.gitconfig" \ # Mount Git config, optionally.
  danguita/shell:latest
```

### Release

```shell
$ DOCKER_IMAGE_NAME=danguita/shell DOCKER_IMAGE_TAG=latest DOCKER_REGISTRY_URL=docker.io \
  make release
```

## License

MIT.
