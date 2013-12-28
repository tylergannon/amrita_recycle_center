require 'spec_helper'

describe Transfer do
  subject {build :transfer}
  
  it {should have_many(:transfer_line_items)}
  it {should validate_presence_of(:transferred_at)}
  
  describe "#transfer_line_items.debit" do
    let(:credits) {[]}
    before do
      3.times{ credits << subject.transfer_line_items.build(gross_weight: 10) }
    end
    describe "when there is a line item with weight < 0" do
      it "should return that item" do
        subject.transfer_line_items.build gross_weight: -12.34
        subject.transfer_line_items.debit.gross_weight.should == -12.34
      end
    end
    
    describe "when there is no line item with weight < 0" do
      it "should be nil" do
        subject.transfer_line_items.debit.should be_nil
      end
    end
  end
  
  describe "#transfer_line_items.credit" do
    let(:credits) {[]}
    before do
      subject.transfer_line_items.build gross_weight: -12.34
    end
    describe "when there is a line item with weight > 0" do
      it "should return those items" do
        3.times{ credits << subject.transfer_line_items.build(gross_weight: 10) }
        subject.transfer_line_items.credit.to_a.should == credits
      end
    end
    describe "when there are no credits" do
      it "should be empty" do
        subject.transfer_line_items.credit.should be_empty
      end
    end
  end
  
  describe "validations" do
    describe "when there is no #debit line item" do
      it "should fail validation" do
        true.should be_false
      end
    end
    
    describe "when the debits and credits do not balance" do
      it "should fail validation" do
        true.should be_false
      end
    end
    
    pending "once you get this, then you can add code elsewhere (Transfers Factory, Transfers Controller, etc., that creates the debit line item automatically.  Just make sure that you don't allow saving without it or else you'll have bad data.)"
  end
  
  describe "managing the gross weight of the debit" do
    let(:container) {create :container, empty_weight: 1}
    before do
      subject.transfer_line_items.build gross_weight: -23
      subject.transfer_line_items.build gross_weight: 101
      subject.transfer_line_items.build gross_weight: 11
      subject.transfer_line_items.build gross_weight: 2
      subject.save
    end
    it "should set the weight on the debit to offset the sum of the NET WEIGHTS of the credits" do
      subject.debit.gross_weight.should == -(111)
    end
  end
  
  describe "after_initialize callback" do
    let(:time) {Time.zone.parse('2013-12-27 10:37:00')}
    
    describe "when the object is new" do
      it "should set the transferred_at to the current time" do
        Timecop.freeze time
        transfer = build :transfer
        transfer.transferred_at.should == time
        Timecop.return
      end
    end
    
    describe "when the object was already created" do
      let(:transfer_time) {Time.zone.parse('2013-12-25')}
      it "should do not change the time" do
        Timecop.freeze time
        id = create(:transfer, transferred_at: transfer_time).id
        transfer = Transfer.find(id)
        transfer.transferred_at.should_not == time
        Timecop.return
      end
    end
  end
end
