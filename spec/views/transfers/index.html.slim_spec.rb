require 'spec_helper'

describe "transfers/index" do
  before(:each) do
    assign(:transfers, [
      stub_model(Transfer),
      stub_model(Transfer)
    ])
  end

  it "renders a list of transfers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
