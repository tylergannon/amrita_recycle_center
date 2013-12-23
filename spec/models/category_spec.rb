require 'spec_helper'

describe Category do
  subject {build :category}
  it {should validate_presence_of(:name)}
end
