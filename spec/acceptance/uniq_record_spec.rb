require 'spec_helper'
require 'acceptance/acceptance_helper'

describe "uniq_record" do
  include FactoryGirl::Syntax::Methods

  before do
    define_model('User', :name => "string") do
      validates_uniqueness_of :name
    end

    define_model('Message', :from_user_id => :integer, :to_user_id => :integer) do
      belongs_to :sender, :class_name => "User", :foreign_key => "from_user_id"
      belongs_to :recepient, :class_name => "User", :foreign_key => "to_user_id"
    end

    FactoryGirl.define do
      factory :user, :uniq_record => true  do
        name "John"
      end

      factory :message do
        association :sender, :factory => :user
        association :recepient, :factory => :user
      end
    end
  end

  subject { create('message') }

  it "saves" do
    should_not be_new_record
  end
  it "equals" do
    subject.sender.id.should == subject.recepient.id
  end

#  it "assigns and saves associations" do
#    subject.user.should be_kind_of(User)
#    subject.user.should_not be_new_record
#  end
end

