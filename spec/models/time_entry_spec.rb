require 'spec_helper'

describe TimeEntry do
  subject {build :time_entry}
  
  describe "#reporting_date" do
    it "should default to today" do
      subject.reporting_date.should == Time.zone.today
    end
  end
  
  describe "before_save callback" do
    describe "when #reporting_date has been set" do
      let(:reporting_date) {"2013-01-22"}
      before do
        subject.reporting_date = reporting_date
      end
      it "should reset start_time" do
        subject.start_time = "9:30"
        subject.save
        subject.start_time.should == Time.zone.parse("2013-01-22 9:30")
      end
      it "should reset end_time" do
        subject.end_time = "9:30"
        subject.save
        subject.end_time.should == Time.zone.parse("2013-01-22 9:30")
      end
    end
    describe "when #reporting_date is nil" do
      before do
        subject.reporting_date = nil
      end
      it "should not reset start_time" do
        Timecop.freeze do
          subject.start_time = Time.zone.now
          subject.save
          subject.start_time.should == Time.zone.now
        end
      end
      it "should not reset end_time" do
        Timecop.freeze do
          subject.end_time = Time.zone.now
          subject.save
          subject.end_time.should == Time.zone.now
        end
      end
    end
  end
end
