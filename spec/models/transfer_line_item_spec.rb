require 'spec_helper'

describe TransferLineItem do
  subject {build :transfer_line_item}
  
  it {should belong_to(:account)}
  it {should belong_to(:container)}
  it {should belong_to(:transfer)}
  
  describe "net weight validation" do
    describe "when net weight equals difference between gross_weight and container.empty_weight" do
      before do
        
      end
    end
  end
end
