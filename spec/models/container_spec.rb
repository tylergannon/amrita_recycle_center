require 'spec_helper'

describe Container do
  subject {build :container}
  it {should validate_presence_of(:name)}
  it {should validate_numericality_of(:capacity)}
  it {should validate_numericality_of(:empty_weight)}
  
end
