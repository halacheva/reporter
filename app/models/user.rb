class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :reports,  dependent: :destroy

  has_attached_file :avatar,
                    styles: { profile: '200x200>', thumb: '100x100#' },
                    path: '/system/:class/:attachment/:id_partition/:style/:hash_:filename',
                    url: '/system/:class/:attachment/:id_partition/:style/:hash_:filename',
                    default_url: '/images/:style/missing.png',
                    hash_secret: 'HiperMegaSecretString',
                    storage: :dropbox,
                    dropbox_credentials: Rails.root.join('config/dropbox.yml')

  # Validate content type
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # Validate filename
  validates_attachment_file_name :avatar, matches: [/png\Z/i, /jpe?g\Z/i]

  process_in_background :avatar, only_process: [:profile]

  attr_accessor :delete_avatar

  before_save :delete_avatar?

  private

  def delete_avatar?
    avatar.clear if delete_avatar.to_i == 1
  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
    end
  end
end
