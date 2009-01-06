# name:string email:string password_hash:string identifier_hash:string receive_emails:boolean
class SandboxUser < ActiveRecord::Base
  
  class << self
    def authenticate(username, password)
      user = find_by_username username
      user && user.valid_password?(password) ? user : false
    end
  end
  
  attr_accessor :password
  
  validates_presence_of :name, :email, :username
  validates_format_of :email, :with => /^[\w\._+%-]+@[\w\.-]+\.[a-zA-Z]{2,6}$/,
      :message => "not in the proper username@domain.com format"
  
  validates_format_of :username, :with => /^[a-z][\w_]{3,}$/i,
      :message => "must be at least four characters and begin with letter" 
  
  validates_uniqueness_of :username
  
  before_save :encrypt_password
  
  def valid_password?(possible_password)
    MD5.md5(possible_password).to_s == self.encrypt_password
  end
  
  private
  
    def encrypt_password
      if password
        self.password_hash   = MD5.md5(password).to_s
        self.identifier_hash = MD5.md5("#{username}:#{password}").to_s
      end
    end
    
end
