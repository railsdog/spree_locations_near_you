require 'spec_helper'
"puts hello"
describe Spree::Venue do
  context "validations" do
    it { should validate_presence_of :name }
  end
end
