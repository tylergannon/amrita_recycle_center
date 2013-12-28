require 'spec_helper'

describe TransferLineItem do
  subject {build :transfer_line_item}
  
  it {should belong_to(:account)}
  it {should belong_to(:container)}
  it {should belong_to(:transfer)}

end
