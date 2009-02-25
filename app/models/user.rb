require 'digest/sha1'
require 'md5'

class User < ActiveRecord::Base
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_presence_of :name
  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :reset_api_key

  attr_accessible :login, :email, :name, :password, :password_confirmation, :skype, :receive_emails
  
  class << self
    
    def authenticate(login, password)
      return nil if login.blank? || password.blank?
      u = find_in_state :first, :active, :conditions => {:login => login.downcase} # need to get the salt
      u && u.authenticated?(password) ? u : nil
    end
    
    def id_from_pin_number(pin)
      pin = pin.to_s
      if Verhoeff.checks_out?(pin) && Verhoeff.checks_out?(pin[0..-2].reverse)
        pin[1..-2].reverse.to_i - 1337
      else
        nil  
      end
    end
    
    def find_by_pin_number(pin)
      id = id_from_pin_number pin
      find(id) if id
    end
  end

  def admin?
    %w[jicksta jsgoecke].include? login
  end
  
  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def authenticated?(password)
    if salt.blank?
      # This is for the legacy SandboxUser accounts that don't have salts.
      MD5.md5(password).to_s == crypted_password
    else
      super
    end
  end
  
  def pin_valid?(pin)
    pin == pin_number
  end
  
  def pin_number
    Verhoeff.checksum_of Verhoeff.checksum_of(1337 + id).to_s.reverse
  end
  
  def reset_api_key
    self.api_key = self.class.make_token
  end

  protected
  
    def encrypt_password
      if salt.blank? && !new_record? && password
        self.salt = self.class.make_token
      end
      #   # This is for the legacy SandboxUser accounts that don't have salts.
      #   self.crypted_password = MD5.md5(password).to_s
      # else
        super
      # end
      if password
        self.identifier_hash  = MD5.md5("#{login}:#{password}").to_s
      end
    end
    
    def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
    end


end
