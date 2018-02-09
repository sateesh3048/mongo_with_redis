# require 'dragonfly'
class User
  include Mongoid::Document
  include Mongoid::AuditLog
  extend Dragonfly::Model
  include Mongoid::Document::Taggable

  validates :name, presence: true, message: I18n.t(:bad_name)

  field :name, type: String
  field :email, type: String
  field :gender, type: String
  field :status, type: String
  field :image_uid, type: String
  field :title, type: String

  dragonfly_accessor :image


  def self.test_audit
    Mongoid::AuditLog.record do 
      User.create!(name: "Log_Testing", email: "log@gmail.com", gender: "M", status: "Active")
    end
  end


  def self.create_lists
    statues =["Active", "InActive"]
    genders = ["M", "F"]
    (1..50).each do |user|
      name = Faker::Name.name
      email = Faker::Internet.email
      gender = genders.sample
      status = statues.sample
      User.create!(name: name, email: email, gender: gender, status: status)
    end
  end

  def thumb_image
    self.image.thumb('300x200#').url rescue nil
  end
end
