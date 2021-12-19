#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/github/codeql-cli-binaries"
TOOL_NAME="codeql"
TOOL_TEST="codeql --help"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # TODO: Use the GitHub releases API instead? Would have to paginate if so
  list_github_tags
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  case $(uname | tr '[:upper:]' '[:lower:]') in
  linux*)
    local platform="linux64"
    ;;
  darwin*)
    local platform="osx64"
    ;;
  *)
    fail "Platform download not supported."
    ;;
  esac

  url="$GH_REPO/releases/download/v${version}/codeql-${platform}.zip"

  echo "* Downloading $TOOL_NAME release $version..."
  # TODO: GitHub seems unhappy with -C - but doing this could lead to partial files
  if ! [ -f "$filename" ]; then
    curl "${curl_opts[@]}" -o "$filename" "$url" || fail "Could not download $url"
  fi
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    unzip -qq "$ASDF_DOWNLOAD_PATH/$TOOL_NAME-$ASDF_INSTALL_VERSION.zip" -d "$install_path"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
