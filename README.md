# danguita's shell

## Motivation

The motivation behind this is to be able to build and distribute a highly
portable development machine with all configuration and tooling I need in
my day to day work, ready to be used locally or on a server out of the
box.

For instance, the current configuration provides the following setup:

- `zsh` shell.
- `tmux` window manager.
- `vim` editor.
- `git`, `curl`, `fzf`, `jq` and some other tools.
- My [dotfiles](https://github.com/danguita/dotfiles).

## Usage

### Build

```shell
$ make build
```

#### Using a custom Docker registry

```shell
$ DOCKER_IMAGE_NAME=wadus.davidanguita.name:5000/danguita/shell make build
```

### Run

```shell
$ docker run -it --rm \
--net=host \                             # Use host networking, optionally.
-v "$(pwd):/workspace" \                 # Mount `pwd` at `/workspace`.
-v "$HOME/.ssh:/root/.ssh" \             # Mount SSH config, optionally.
-v "$HOME/.gnupg:/root/.gnupg" \         # Mount GPG config, optionally.
-v "$HOME/.gitconfig:/root/.gitconfig" \ # Mount Git config, optionally.
danguita/shell:latest
```

### Release

```shell
$ make release
```

#### Using a custom Docker registry

```shell
$ DOCKER_IMAGE_NAME=wadus.davidanguita.name:5000/danguita/shell make release
```

## License

MIT.
