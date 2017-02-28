class User < ApplicationRecord
  validates :username, presence: true
  has_one :api_key
  delegate :access_token, to: :api_key
  has_many :boards

  def self.find_by_token(token)
    joins(:api_key).find_by("api_keys.access_token = '#{token}'")
  end
end
