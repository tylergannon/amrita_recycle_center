require 'spec_helper'

describe Account do
  subject {build :account}
  it {should validate_presence_of(:location)}
  it {should validate_presence_of(:category)}
  

end
