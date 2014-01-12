require 'spec_helper'

describe "time_entries/edit" do
  before(:each) do
    @time_entry = assign(:time_entry, create(:time_entry))
  end

  it "renders the edit time_entry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", time_entry_path(@time_entry), "post" do
      assert_select "select#time_entry_task_id[name=?]", "time_entry[task_id]"
    end
  end
end
