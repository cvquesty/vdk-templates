# Changelog

All notable changes to this project will be documented in this file.

**VDK Templates** is a community fork of [pdk-templates](https://github.com/puppetlabs/pdk-templates), maintained by [Vox Pupuli](https://voxpupuli.org/).

## [0.1.0] - 2026-03-17

### 🎉 Initial Release

VDK Templates is a community fork of pdk-templates, rebranded for the VDK/OpenVox ecosystem.

### Added

- `.yamllint.yml` configuration for CI YAML linting
- SSH deploy key authentication for private repo CI access
- `webfactory/ssh-agent` step in nightly workflow for VDK source builds

### Changed

- Renamed all PDK references to VDK across templates, CI scripts, and docs
- Updated for use with [openvox-lint](https://github.com/cvquesty/openvox-lint)
- Renamed `.ci/install_pdk.sh` → `.ci/install_vdk.sh`
- `.ci/test_script.sh` updated to use `vdk` commands
- `.ci/install_vdk.sh` uses SSH clone URL for VDK source builds
- Bumped `actions/checkout` to v6 across all workflows (nightly, ci, release_prep)
- Nightly workflow: added Ruby setup step, VDK environment variables
- CI YAML validation: allow YAML aliases (`aliases: true`) for Ruby 3.1+ compatibility
- Renamed `docs/testing-pdk-module-gemfile-sources.md` → `docs/testing-vdk-module-gemfile-sources.md`
- Updated `config_defaults.yml`, `NOTICE`, and object templates for VDK branding

### Heritage

VDK Templates inherits all templates from pdk-templates. For historical changelog, see the [pdk-templates repository](https://github.com/puppetlabs/pdk-templates/blob/main/CHANGELOG.md).
