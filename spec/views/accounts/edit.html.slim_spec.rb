require 'spec_helper'

describe "accounts/edit" do
  before(:each) do
    @account = assign(:account, stub_model(Account,
      :category => nil,
      :location => nil,
      :slug => "MyString",
      :incoming => false
    ))
  end

  it "renders the edit account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", account_path(@account), "post" do
      assert_select "input#account_category[name=?]", "account[category]"
      assert_select "input#account_location[name=?]", "account[location]"
      assert_select "input#account_slug[name=?]", "account[slug]"
      assert_select "input#account_incoming[name=?]", "account[incoming]"
    end
  end
end
