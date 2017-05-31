class User < ApplicationRecord
  rolify
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login

  has_one :profile
  has_many :work_schedules

  after_create :build_user_profile

  def is_admin?
    has_role? :admin
  end

  def name
    profile.try(:name).try(:capitalize)
  end

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  protected
    def build_user_profile
      self.build_profile.save
    end

    def self.find_record login
      where(["username = :value OR email = :value", {value: login}]).first
    end

    def self.find_recoverable_or_initialize_with_errors required_attributes, attributes, error = :invalid
      (case_insensitive_keys || []).each {|k| attributes[k].try(:downcase!)}

      attributes = attributes.slice(*required_attributes)
      attributes.delete_if {|_key, value| value.blank?}

      if attributes.size == required_attributes.size
        if attributes.key?(:login)
          login = attributes.delete(:login)
          record = find_record(login)
        else
          record = where(attributes).first
        end
      end

      unless record
        record = new

        required_attributes.each do |key|
          value = attributes[key]
          record.send("#{key}=", value)
          record.errors.add(key, value.present? ? error : :blank)
        end
      end
      record
    end

    def self.send_reset_password_instructions attributes = {}
      recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
      recoverable.send_reset_password_instructions if recoverable.persisted?
      recoverable
    end

end
