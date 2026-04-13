# frozen_string_literal: true

require 'spec_helper'
require 'puppet/transport/schema/test_transport'

RSpec.describe 'the test_transport transport' do
  it 'loads' do
    expect(Puppet::ResourceApi::Transport.list['test_transport']).not_to be_nil
  end
end
