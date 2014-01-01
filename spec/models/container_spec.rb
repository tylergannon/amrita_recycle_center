require 'spec_helper'

describe Container do
  subject {build :container}
  it {should validate_presence_of(:name)}
end
