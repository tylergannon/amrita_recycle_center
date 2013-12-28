require 'spec_helper'

describe Transfer do
  subject {build :transfer}
  
  it {should have_many(:transfer_line_items)}
  it {should validate_presence_of(:transferred_at)}
  
  describe "#transfer_line_items.debit" do
    before do
      3.times{ subject.transfer_line_items.build(gross_weight: 10) }
    end
    describe "when there is a line item with weight < 0" do
      it "should return that item" do
        subject.transfer_line_items.build gross_weight: -12.34
        subject.transfer_line_items.debit.gross_weight.should == -12.34.to_d
      end
    end
  end
  
  describe "before_save callback" do
    
    
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
