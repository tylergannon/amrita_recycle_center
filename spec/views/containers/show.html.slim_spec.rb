require 'spec_helper'

describe "containers/show" do
  before(:each) do
    @container = assign(:container, stub_model(Container,
      :name => "Name",
      :capacity => "9.99",
      :empty_weight => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
  end
end
