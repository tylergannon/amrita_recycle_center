require 'spec_helper'

describe "transfer_line_items/edit" do
  before(:each) do
    @transfer_line_item = assign(:transfer_line_item, stub_model(TransferLineItem,
      :credit => false,
      :account => nil,
      :container => nil,
      :gross_weight => "9.99",
      :net_weight => "9.99"
    ))
  end

  it "renders the edit transfer_line_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transfer_line_item_path(@transfer_line_item), "post" do
      assert_select "input#transfer_line_item_credit[name=?]", "transfer_line_item[credit]"
      assert_select "input#transfer_line_item_account[name=?]", "transfer_line_item[account]"
      assert_select "input#transfer_line_item_container[name=?]", "transfer_line_item[container]"
      assert_select "input#transfer_line_item_gross_weight[name=?]", "transfer_line_item[gross_weight]"
      assert_select "input#transfer_line_item_net_weight[name=?]", "transfer_line_item[net_weight]"
    end
  end
end
