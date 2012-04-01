class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :username, :number, :password, :password_confirmation
  # Automatically creates the virtual attribute 'password_confirmation'.
  validates :password, :presence => true,
  		       :confirmation => true,
 		       :length => { :within => 6..40}
  validates :name,  :presence => true,
                  :length   => { :maximum => 50 }
  before_save :encrypt_password
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
  end
  
  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
   
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
