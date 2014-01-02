require 'spec_helper'

describe Transfer do
  subject {build :transfer}

  it {should have_many(:transfer_line_items)}
  it {should validate_presence_of(:transferred_at)}
  
  describe "#net_weight" do
    subject {build :transfer}
    describe "when there are no debit line items" do
      it "should be zero" do
        subject.balance!
        expect(subject.net_weight).to equal(0)
      end
    end
    describe "when there are debit line items" do
      before do
        subject.transfer_line_items += [
          build(:transfer_line_item, container: Container.no_container, gross_weight: 100),
          build(:transfer_line_item, container: Container.no_container, gross_weight: 10),
          build(:transfer_line_item, container: Container.no_container, gross_weight: 1) ]
        subject.balance!
      end

      it "should be the sum" do
        subject.net_weight.should == 111
      end
    end
    
    describe "when the transfer is not valid" do
      before do
        subject.stub(:valid?).and_return false
      end
      it "should raise an error" do
        ->{subject.net_weight}.should raise_error
      end
    end
  end
  
  
  describe "#transfer_line_items.credit" do
    let(:credits) {[]}
    before do
      subject.debit_attributes = {gross_weight: -12.34}
    end
    describe "when there is a line item with weight > 0" do
      it "should return those items" do
        3.times{ credits << subject.transfer_line_items.build(gross_weight: 10) }
        subject.transfer_line_items.select{|t| t.credit}.should == credits
      end
    end
    describe "when there are no credits" do
      it "should be empty" do
        subject.credits.should be_empty
      end
    end
  end
  
  describe "#balance" do
    let(:container) {create :container, empty_weight: 2}
    let(:transfer) {build :transfer}
    
    let(:credit) {create :transfer_line_item, container: container, gross_weight: 10, net_weight: 10-container.empty_weight}
    
    before do
      transfer.debit.attributes = {gross_weight: -16}
      transfer.transfer_line_items << credit
      transfer.save
    end
    
    it "should be the sum of all the net weights of the line items" do
      transfer.balance.should == -8
    end
  end
    
  describe "#balance!" do
    let(:container) {create :container, empty_weight: 1}
    before do
      subject.debit.gross_weight = -23
      subject.transfer_line_items += [
        build(:balanced_transfer_line_item, container: container, gross_weight: 101),
        build(:balanced_transfer_line_item, container: container, gross_weight: 11),
        build(:balanced_transfer_line_item, container: container, gross_weight: 2),
      ]
    end
    it "should set the weight on the debit to offset the sum of the NET WEIGHTS of the credits" do
      subject.balance.should_not == 0
      subject.balance!
      subject.balance.should == 0
    end
  end
  
  describe "#debit_attributes" do
    it "should set the attributes on the debit line item" do
      subject.debit_attributes = {gross_weight: -123}
      subject.debit.gross_weight.should == -123
    end
  end

  let(:source_account) {create :account}
  let(:location) {create :location, name: 'Waste Station'}
  let(:category1) {create :category, name: 'Hard Items'}
  let(:category2) {create :category, name: 'Paper'}
  
  describe "#transfer_line_item_attributes" do
    let(:container) {create(:container)}
    let(:attributes) {
      { "0" => {
          gross_weight: 100, container_id: container.id, location_id: location.id, category_id: category1.id},
        "1" => {
          gross_weight: 1000, container_id: container.id, location_id: location.id, category_id: category2.id}
    }}
    subject {build :transfer}
    before do
      subject.debit_attributes = {gross_weight: -1}
      subject.transfer_line_items_attributes = attributes
    end
    it "should not destroy the debit" do
      subject.debit.should_not be_nil
      subject.debit.gross_weight.should == -1
    end
    it "should add the new items" do
      subject.transfer_line_items.size.should == 3
    end
  end
  
  describe "after_find callback" do
    let(:transfer) {create :balanced_transfer}
    it "should set the @debit variable" do
      the_trans = Transfer.find(transfer.id)
      the_trans.debit.should == transfer.debit
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
        id = create(:balanced_transfer, transferred_at: transfer_time).id
        transfer = Transfer.find(id)
        transfer.transferred_at.should_not == time
        Timecop.return
      end
    end
    
    describe "creating debit" do
      it "should build the debit transaction immediately." do
        Transfer.new.debit.should be_kind_of(TransferLineItem)
      end
      it "should build a debit transaction with NO_CONTAINER" do
        Transfer.new.debit.container.should == Container.no_container
      end
    end
  end
end
