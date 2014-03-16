class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reports,  dependent: :destroy

  has_attached_file :avatar,
    :styles => { :profile => "200x200>", :thumb => "70x70#"},
    :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:hash_:filename",
    :url => "/system/:class/:attachment/:id_partition/:style/:hash_:filename",
    :hash_secret => "HiperMegaSecretString",
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")

  # Validate content type
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Validate filename
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/i]

  process_in_background :avatar, :only_process => [:profile]
end
