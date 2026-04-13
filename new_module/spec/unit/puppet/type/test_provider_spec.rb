# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/test_provider'

RSpec.describe 'the test_provider type' do
  it 'loads' do
    expect(Puppet::Type.type(:test_provider)).not_to be_nil
  end
end
