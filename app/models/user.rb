class User < ActiveRecord::Base
  has_many :relations

  include Redis::Objects
  set :friend_id_set

  def calc_friend_id_set
    friend_id_set.add(relations.pluck(:friend_id)) if friend_id_set.empty?
  end

  def fast_mutual_friend_ids(friend)
    calc_friend_id_set
    friend.calc_friend_id_set
    friend_id_set.inter(friend.friend_id_set)
  end

  def slow_mutual_friend_ids(friend)
    Relation.joins("JOIN relations t2 on relations.friend_id = t2.user_id")
      .where("relations.user_id = ? AND t2.friend_id = ?", id, friend.id)
      .select("relations.friend_id")
      .map(&:friend_id)
      .uniq
  end

  def mutual_friends(friend)
    User.where(id: fast_mutual_friend_ids(friend))
  end
end
