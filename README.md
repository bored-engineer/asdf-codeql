<div align="center">

# asdf-codeql [![Build](https://github.com/bored-engineer/asdf-codeql/actions/workflows/build.yml/badge.svg)](https://github.com/bored-engineer/asdf-codeql/actions/workflows/build.yml) [![Lint](https://github.com/bored-engineer/asdf-codeql/actions/workflows/lint.yml/badge.svg)](https://github.com/bored-engineer/asdf-codeql/actions/workflows/lint.yml)


[codeql](https://github.com/github/codeql-cli-binaries) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `zip`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add codeql
# or
asdf plugin add codeql https://github.com/bored-engineer/asdf-codeql.git
```

codeql:

```shell
# Show all installable versions
asdf list-all codeql

# Install specific version
asdf install codeql latest

# Set a version globally (on your ~/.tool-versions file)
asdf global codeql latest

# Now codeql commands are available
codeql --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/bored-engineer/asdf-codeql/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Luke Young](https://github.com/bored-engineer/)
