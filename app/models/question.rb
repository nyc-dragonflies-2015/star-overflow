class Question < ActiveRecord::Base

  belongs_to :user
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :answers



  def self.known_user?(session)
    unless session != nil
      return false
    end
  end
end
