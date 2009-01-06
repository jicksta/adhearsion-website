require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SandboxUser do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :email => "value for email",
      :password_hash => "value for password_hash",
      :identifier_hash => "value for identifier_hash",
      :receive_emails => false
    }
  end

  it "should create a new instance given valid attributes" do
    SandboxUser.create!(@valid_attributes)
  end
end
