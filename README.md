# VDK Templates

[![CI](https://github.com/cvquesty/vdk-templates/actions/workflows/ci.yml/badge.svg)](https://github.com/cvquesty/vdk-templates/actions/workflows/ci.yml)
[![Nightly](https://github.com/cvquesty/vdk-templates/actions/workflows/nightly.yml/badge.svg)](https://github.com/cvquesty/vdk-templates/actions/workflows/nightly.yml)

This repository contains the default templates used by [VDK](https://github.com/cvquesty/vdk) (Vox Development Kit) when creating new Puppet/OpenVox modules and generating module content.

VDK Templates is a community fork of [pdk-templates](https://github.com/puppetlabs/pdk-templates), maintained by [Vox Pupuli](https://voxpupuli.org/).

## Using Custom Templates

You can use these templates (or your own fork) with VDK:

```bash
# Use default templates
vdk new module mymodule

# Use a specific template repository
vdk new module mymodule --template-url=https://github.com/cvquesty/vdk-templates

# Use a specific branch/tag
vdk new module mymodule --template-url=https://github.com/cvquesty/vdk-templates --template-ref=main
```

## Template Structure

```
vdk-templates/
├── config_defaults.yml    # Default configuration values
├── moduleroot/            # Files that go in every module
│   ├── .github/           # GitHub workflows
│   ├── Gemfile.erb        # Ruby dependencies
│   ├── Rakefile.erb       # Rake tasks
│   └── spec/              # Test scaffolding
├── moduleroot_init/       # Files only for new modules
│   ├── README.md.erb      # Module README
│   ├── CHANGELOG.md.erb   # Changelog
│   └── metadata.json.erb  # Module metadata
└── object_templates/      # Templates for generated content
    ├── class.erb          # Puppet class
    ├── defined_type.erb   # Defined type
    ├── task.erb           # Bolt task
    └── ...
```

## Customizing Templates

To customize templates for your organization:

1. Fork this repository
2. Modify templates as needed
3. Use your fork with VDK:
   ```bash
   vdk new module mymodule --template-url=https://github.com/YOUR_ORG/vdk-templates
   ```

### config_defaults.yml

The `config_defaults.yml` file contains default values that templates can use:

```yaml
common:
  summary: 'A module to manage things'
  license: 'Apache-2.0'
  
Gemfile:
  optional:
    ':development':
      - gem: 'puppet-debugger'
```

## Module .sync.yml

Modules can override template defaults by creating a `.sync.yml` file:

```yaml
# .sync.yml
Gemfile:
  optional:
    ':development':
      - gem: 'my-custom-gem'

.rubocop.yml:
  unmanaged: true  # Don't overwrite this file
```

## Contributing

Contributions are welcome! Please see the [VDK repository](https://github.com/cvquesty/vdk) for contribution guidelines.

## License

Apache-2.0
