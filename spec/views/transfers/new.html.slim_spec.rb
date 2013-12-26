require 'spec_helper'

describe "transfers/new" do
  before(:each) do
    assign(:transfer, stub_model(Transfer).as_new_record)
  end

  it "renders new transfer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transfers_path, "post" do
    end
  end
end
