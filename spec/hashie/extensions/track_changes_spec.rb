require 'spec_helper'

describe Hashie::Extensions::TrackChanges do
  let(:subclass) {
    Class.new(Hash) do
    include Hashie::Extensions::TrackChanges
    end
  }

  subject { subclass.new }

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
      subject[:key] = subclass.new
      subject[:key][:foo] = true
    end

    specify "changes should be recursive" do
      subject.changes[:key][:foo].should == subject[:key][:foo]
    end
  end
end
