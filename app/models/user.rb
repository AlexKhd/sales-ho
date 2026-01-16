class User < ApplicationRecord
  rolify
  self.primary_key = "userid"

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true, length: { maximum: 45 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 45 }
  validates_presence_of :dist_id, :ownerdist_id

  before_validation :check_dists
  before_save :set_userid

  private

  def check_dists
    self.dist_id = Option.get_distid
    self.ownerdist_id = Option.get_distid
  end

  def set_userid
    # fids: 10000005 - sample with distid = 1 (5550000005 with 555)
    return if self.userid.present?
    max_id = User.maximum(:userid)
    if max_id #< 1000 # only server records exists, starting from 1
      self.userid = max_id + 1
    else # 1st record
      increment_str = "0000001"
      user_distid = Option.get_distid
      self.userid = "#{user_distid}#{increment_str}"
    end
  end
end
