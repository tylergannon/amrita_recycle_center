require 'spec_helper'

describe "containers/new" do
  before(:each) do
    assign(:container, stub_model(Container,
      :name => "MyString",
      :capacity => "9.99",
      :empty_weight => "9.99"
    ).as_new_record)
  end

  it "renders new container form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", containers_path, "post" do
      assert_select "input#container_name[name=?]", "container[name]"
      assert_select "input#container_capacity[name=?]", "container[capacity]"
      assert_select "input#container_empty_weight[name=?]", "container[empty_weight]"
    end
  end
end
