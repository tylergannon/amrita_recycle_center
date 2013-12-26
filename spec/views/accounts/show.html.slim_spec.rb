require 'spec_helper'

describe "accounts/show" do
  before(:each) do
    @account = assign(:account, stub_model(Account,
      :category => nil,
      :location => nil,
      :slug => "Slug",
      :incoming => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Slug/)
    rendered.should match(/false/)
  end
end
