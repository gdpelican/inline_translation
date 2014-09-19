require 'spec_helper'

describe Babbel do
  it "Should be set to the current version" do
    expect(Babbel::VERSION).to eq '0.0.1'
  end
end