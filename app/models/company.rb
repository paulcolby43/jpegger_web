class Company < ApplicationRecord
  before_save :default_jpegger_service_ip
  before_save :default_jpegger_service_port
  
  has_many :users
  
#  mount_uploader :logo, LogoUploader
  
  validates_presence_of :name, :jpegger_service_ip, :jpegger_service_port
  
  ############################
  #     Instance Methods     #
  ############################
  
  # Set the default Jpegger service IP to what's set in environment variable
  def default_jpegger_service_ip
    self.jpegger_service_ip ||= "#{ENV['JPEGGER_SERVICE']}"
  end
  
  # Set the default Jpegger service port to 3332
  def default_jpegger_service_port
    self.jpegger_service_port ||= "3332"
  end
  
  #############################
  #     Class Methods         #
  #############################
end