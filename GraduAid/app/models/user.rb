class User < ActiveRecord::Base
  has_many :takens
  validates :first_name, :last_name, :presence => true
  validates :email, {:uniqueness => {:message => "The account with this address has already existed"}, 
                          :presence => {:message => "(Email) can't be blank"}}
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true

  def password
    return @temp
  end

  def password= (frm_password)
    @temp = frm_password
    self.salt = rand().to_s
    self.password_digest = Digest::SHA1.hexdigest(frm_password + self.salt)
  end

  def password_valid?(cand_password)
    if cand_password.length < 8
      return false
    end
    return (self.password_digest == Digest::SHA1.hexdigest(cand_password + self.salt))
  end

  def email_valid?(cand_email)
    return (/[a-zA-Z0-9\._]+@stanford.edu/ !~ cand_email)
  end
end
