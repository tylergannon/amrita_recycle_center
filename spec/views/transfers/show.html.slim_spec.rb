require 'spec_helper'

describe "transfers/show" do
  before(:each) do
    @transfer = assign(:transfer, stub_model(Transfer))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
