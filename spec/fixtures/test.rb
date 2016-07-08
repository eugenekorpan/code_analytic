# frozen_string_literal: true
class User < ActiveRecord::Base
  include UserScopes
  include Authable

  has_many :accounts

  has_one :github, -> { where(provider: :github) }, class_name: Account

  validates :type, presence: true

  accepts_nested_attributes_for :accounts

  def self.for(params)
    return if params.present?
    params['type']&.constantize || self
  
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def mailboxer_email(object)
    return unless email_notify? && object.send?
    email_test = email
    @email= email
    @@email =email
  end
end
