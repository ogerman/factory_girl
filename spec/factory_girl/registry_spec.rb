require 'spec_helper'

describe FactoryGirl::Registry do
  subject { FactoryGirl::Registry.new }

  it "registers a factory" do
    name = "object"
    factory = FactoryGirl::Factory.new(name)
    subject.add(factory)
    subject.find(name).should == factory
  end

  it "can be accessed like a hash"

  it "iterates registered factories"

  it "registers an sequence"

  it "doesn't allow a duplicate name" do
    factory = FactoryGirl::Factory.new(:object)
    expect { 2.times { subject.add(factory) } }.
      to raise_error(FactoryGirl::DuplicateDefinitionError)
  end

  it "registers aliases" do
    aliases = [:thing, :widget]
    factory = FactoryGirl::Factory.new(:object, :aliases => aliases)
    subject.add(factory)
    aliases.each do |name|
      subject.find(name).should == factory
    end
  end
end

