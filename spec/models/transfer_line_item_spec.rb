require 'spec_helper'

describe TransferLineItem do
  subject {build :transfer_line_item}
  
  it {should belong_to(:account)}
  it {should belong_to(:container)}
  it {should belong_to(:transfer)}
  
  describe "net weight validation" do
    describe "when net weight equals difference between gross_weight and container.empty_weight" do
      let(:container) {create :container, empty_weight: 1}
      it "should pass validation" do
        line_item = build :transfer_line_item, container: container, gross_weight: 11, net_weight: 10
        line_item.should be_valid
      end
    end

    describe "when net weight DOES NOT EQUAL difference between gross_weight and container.empty_weight" do
      let(:container) {create :container, empty_weight: 2}
      it "should pass validation" do
        line_item = build :transfer_line_item, container: container, gross_weight: 11, net_weight: 10
        line_item.should_not be_valid
      end
    end
  end
end
