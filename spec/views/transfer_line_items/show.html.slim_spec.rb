require 'spec_helper'

describe "transfer_line_items/show" do
  before(:each) do
    @transfer_line_item = assign(:transfer_line_item, stub_model(TransferLineItem,
      :credit => false,
      :account => nil,
      :container => nil,
      :gross_weight => "9.99",
      :net_weight => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
  end
end
