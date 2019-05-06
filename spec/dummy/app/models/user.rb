# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true

  is_keybase_provable

  def avatar_url
    'face.png'
  end
end
