require 'spec_helper'

describe "containers/edit" do
  before(:each) do
    @container = assign(:container, stub_model(Container,
      :name => "MyString",
      :capacity => "9.99",
      :empty_weight => "9.99"
    ))
  end

  it "renders the edit container form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", container_path(@container), "post" do
      assert_select "input#container_name[name=?]", "container[name]"
      assert_select "input#container_capacity[name=?]", "container[capacity]"
      assert_select "input#container_empty_weight[name=?]", "container[empty_weight]"
    end
  end
end
