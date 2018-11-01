# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  has_many :discussions
  has_many :arguments
  has_many :replies

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data == session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        end
      end
    end


  attr_writer :login

  def login
    @login || username || email
  end

  def side(discussion_id)
    DiscussionsMembersWorker.get_users_side(discussion_id, id)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }])
                            .first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100#' }, default_url: '/images/:style/missing.jpg'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :username, length: { in: 3..12 }
end
