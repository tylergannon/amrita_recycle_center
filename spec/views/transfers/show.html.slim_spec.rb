require 'spec_helper'

describe "transfers/show" do
  before(:each) do
    @transfer = assign(:transfer, create(:balanced_transfer))
    # @debit = @transfer.debit
    # 
    # @credits = [@transfer.transfer_line_items.build(credit: true)]
    # puts @transfer.transfer_line_items.inspect
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
