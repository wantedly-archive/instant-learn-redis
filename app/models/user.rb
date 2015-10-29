class User < ActiveRecord::Base
  has_many :relations

  def friend_ids
    relations.map(&:friend_id)
  end

  def mutual_friend_ids(friend)
     friend_ids & friend.friend_ids
  end

  def mutual_friends(friend)
    User.where(id: mutual_friend_ids(friend))
  end
end
