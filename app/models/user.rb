# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  def request_status(other_user)
    request = FollowRequest.where({:sender_id => self.id, :recipient_id => other_user.id}).at(0)
    if request == nil
      request = FALSE
    end
    return request
  end

  def followings
    follow_requests = FollowRequest.where({:sender_id => self.id, :status => "accepted"})

    return follow_requests
  end

  def followers
    follow_requests = FollowRequest.where({:recipient_id => self.id, :status => "accepted"})
  
    return follow_requests
  end

  def pending_follow_requests
    follow_requests = FollowRequest.where({:recipient_id => self.id, :status => "pending"})
  
    return follow_requests
  end

  has_many(:likes, {:foreign_key => "fan_id"})
  has_many(:photos, {:foreign_key => "owner_id"})
  
end


