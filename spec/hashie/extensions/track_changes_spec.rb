require 'spec_helper'


describe Hashie::Extensions::TrackChanges do
  before(:each) do
    class ExampleTrackableHash < Hash; include Hashie::Extensions::TrackChanges end
  end
  subject { ExampleTrackableHash.new }

  context "single level hash" do
    before(:each) do
      subject[:key] = true
    end

    specify "key should be changed" do
      subject.changed?(:key).should be_true
    end

    specify "changes should include key" do
      subject.changes[:key].should == subject[:key]
    end
  end
  
  context "multi-level hash" do
    before(:each) do
      subject[:key] = ExampleTrackableHash.new
      subject[:key][:foo] = true
    end

    specify "changes should be recursive" do
      subject.changes[:key][:foo].should == subject[:key][:foo]
    end
  end

  after(:each) do
    Object.send(:remove_const, :ExampleTrackableHash)
  end
end
