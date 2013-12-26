require 'spec_helper'

describe "accounts/new" do
  before(:each) do
    assign(:account, stub_model(Account,
      :category => nil,
      :location => nil,
      :slug => "MyString",
      :incoming => false
    ).as_new_record)
  end

  it "renders new account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", accounts_path, "post" do
      assert_select "input#account_category[name=?]", "account[category]"
      assert_select "input#account_location[name=?]", "account[location]"
      assert_select "input#account_slug[name=?]", "account[slug]"
      assert_select "input#account_incoming[name=?]", "account[incoming]"
    end
  end
end
