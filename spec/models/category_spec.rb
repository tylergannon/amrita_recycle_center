require 'spec_helper'

describe Category do
  subject {build :category}
  it {should validate_presence_of(:name)}
  # it {should belong_to(:default_container)}
  # it {should validate_presence_of(:default_container)}
end
