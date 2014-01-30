require 'spec_helper'

describe Category do
  subject {create :category}
  it {should validate_presence_of(:name)}
  it {should belong_to(:default_container)}
  it {should validate_presence_of(:default_container)}
  
  describe "default_container_friendly_id=" do
    let(:default_container) {create :container, name: "A New Container"}
    it "should set the default_container to the one referred to by the given friendly id" do
      subject.default_container.should_not == default_container
      subject.default_container_friendly_id = default_container.friendly_id
      subject.default_container.should == default_container
    end
  end
end
