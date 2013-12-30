require 'spec_helper'

describe TransferLineItem do
  subject {build :transfer_line_item}
  
  it {should belong_to(:account)}
  it {should belong_to(:container)}
  it {should belong_to(:transfer)}

  it {should validate_presence_of(:container)}
  it {should validate_numericality_of(:gross_weight)}
  
  describe "#net_weight=" do
    it "should be private" do
      expect(-> {subject.net_weight = 10}).to raise_error(NoMethodError)
    end
  end
  
  describe "#balance!" do
    describe "when gross_weight >= 0" do
      subject{build :transfer_line_item, gross_weight: 123, net_weight: 0}
      it "should set the net weight to the difference between gross weight and container weight" do
        subject.balance!
        subject.net_weight.should == subject.gross_weight - subject.container.empty_weight
      end
    end
    
    describe "when gross_weight <= 0" do
      subject{build :transfer_line_item, gross_weight: -123, net_weight: 0}
      it "should set the net weight to the difference between gross weight and container weight" do
        subject.balance!
        subject.net_weight.should == subject.gross_weight + subject.container.empty_weight
      end
    end
    
    describe "when container is nil" do
      it "should do nothing" do
        subject.container = nil
        expect(-> {subject.balance!}).not_to raise_error
      end
    end
    
    describe "when abs(gross_weight) < container weight" do
      it "should do nothing" do
        subject.container.empty_weight = 5
        subject.gross_weight = 4
        initial_net_weight = subject.net_weight

        subject.balance!
        subject.net_weight.should == initial_net_weight
      end
    end
  end
  
  describe "before validation" do
    it "should balance the transfer line item." do
      subject.should_receive :balance!
      subject.valid?
    end
  end
  
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
      it "should NOT pass validation" do
        line_item = build :transfer_line_item, container: container, gross_weight: 1, net_weight: 10
        line_item.should_not be_valid
      end
    end
    
    describe "when gross weight is < 0 (i.e. for debits)" do
      let(:container) {create :container, empty_weight: 1}
      it "should validate that the net weight is zero minus the difference between the abs of gross weight and the container" do
        line_item = build :transfer_line_item, container: container, gross_weight: -11, net_weight: -10
        line_item.should be_valid
      end
    end
  end
end
