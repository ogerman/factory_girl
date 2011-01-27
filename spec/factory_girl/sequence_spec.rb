require 'spec_helper'

describe FactoryGirl::Sequence do
  describe "a basic sequence" do
    before do
      @name = :test
      @sequence = FactoryGirl::Sequence.new(@name) {|n| "=#{n}" }
    end

    it "has a name" do
      @sequence.name.should == @name
    end

    it "should start with a value of 1" do
      @sequence.next.should == "=1"
    end

    it "doesn't have aliases" do
      @sequence.aliases.should == []
    end

    describe "after being called" do
      before do
        @sequence.next
      end

      it "should use the next value" do
        @sequence.next.should == "=2"
      end
    end
  end
  
  describe "a custom sequence" do
    before do
      @sequence = FactoryGirl::Sequence.new(:name, "A") {|n| "=#{n}" }
    end

    it "should start with a value of A" do
      @sequence.next.should == "=A"
    end

    describe "after being called" do
      before do
        @sequence.next
      end

      it "should use the next value" do
        @sequence.next.should == "=B"
      end
    end
  end
end
