#!/bin/bash
set -x # echo commands with vars expanded
set -e # exit immediately on error

VDK_GEM="vdk"
VDK_SOURCE_REPO="${VDK_SOURCE_REPO:-https://github.com/voxpupuli/vdk.git}"

install_from_rubygems() {
    echo "Attempting to install VDK from RubyGems..."
    gem install "${VDK_GEM}" --no-document
}

install_from_source() {
    echo "Installing VDK from source (${VDK_SOURCE_REPO})..."
    local build_dir
    build_dir=$(mktemp -d)

    git clone --depth 1 "${VDK_SOURCE_REPO}" "${build_dir}"
    pushd "${build_dir}"
    gem build vdk.gemspec
    gem install vdk-*.gem --no-document
    popd
    rm -rf "${build_dir}"
}

main() {
    if [ -n "${VDK}" ] && [ "${VDK}" != "release" ] && [ "${VDK}" != "nightly" ]; then
        echo "Unknown \$VDK value '${VDK}'. Supported values are 'release' and 'nightly'." >&2
        exit 1
    fi

    # Try RubyGems first, fall back to building from source
    if ! install_from_rubygems; then
        echo "VDK gem not found on RubyGems, building from source..."
        install_from_source
    fi

    vdk --version
}

main "$@"
