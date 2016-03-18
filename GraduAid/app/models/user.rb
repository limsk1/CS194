class User < ActiveRecord::Base
  has_many :takens
  has_many :likes
  has_many :ap_credits
  belongs_to :track
  validates :first_name, :last_name, :presence => true
  validates :email, {:uniqueness => {:message => "account with this address has already existed"}, 
                          :presence => true}
  #validates :password, {:confirmation => {:message => "confirmation not matched"},
  #                        :length => {minimum: 8}}
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
    return (/[a-zA-Z0-9\._]+@stanford.edu/ === cand_email)
  end
end
