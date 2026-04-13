# frozen_string_literal: true

Facter.add(:test_fact) do
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  setcode do
    'hello facter'
  end
end
