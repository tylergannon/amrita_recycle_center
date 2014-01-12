require 'spec_helper'

describe "time_entries/index" do
  before(:each) do
    assign(:time_entries, create_pair(:time_entry))
    assign(:time_entry, build(:time_entry))
  end

  it "renders a list of time_entries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "2014-01-12", :count => 2
  end
end
