require 'spec_helper'

describe "time_entries/new" do
  before(:each) do
    assign(:time_entry, stub_model(TimeEntry,
      :task => nil
    ).as_new_record)
  end

  it "renders new time_entry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", time_entries_path, "post" do
      assert_select "select#time_entry_task_id[name=?]", "time_entry[task_id]"
    end
  end
end
