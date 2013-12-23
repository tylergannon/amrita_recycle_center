require 'spec_helper'

describe Location do
  subject {build :location}
  it {should validate_presence_of(:name)}
  
end
