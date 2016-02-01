class User < ActiveRecord::Base
  has_and_belongs_to_many :courses
  belongs_to :track
  validates :first_name, :last_name, :presence => true
  validates :email, {:uniqueness => {:message => "The account with this address has already existed"}, 
                          :presence => {:message => "(Email) can't be blank"}}
  #validates :password, {:confirmation => true,  :length => {minimum: 8}}
  #validates :password_confirmation, :presence => true

  def password
    return @temp
  end

  def password= (frm_password)
    @temp = frm_password
    self.salt = rand().to_s
    self.password_digest = Digest::SHA1.hexdigest(frm_password + self.salt)
  end

  def password_valid?(cand_password)
    return (self.password_digest == Digest::SHA1.hexdigest(cand_password + self.salt))
  end

  def email_valid?(cand_email)
    return (/[a-zA-Z0-9\._]+@stanford.edu/ !~ cand_email)
  end
end
