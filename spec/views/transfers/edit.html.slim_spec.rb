require 'spec_helper'

describe "transfers/edit" do
  before(:each) do
    @transfer = assign(:transfer, create(:balanced_transfer))
  end

  it "renders the edit transfer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transfer_path(@transfer), "post" do
    end
  end
end
