class Image < ActiveRecord::Base
  has_attached_file :file,
                    styles: { medium: '300x300>', thumb: '100x100#', profile: '200x200>' },
                    path: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                    url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                    default_url: '/images/:style/missing.png',
                    hash_secret: 'HiperMegaSecretString',
                    storage: :dropbox,
                    dropbox_credentials: Rails.root.join('config/dropbox.yml')

  # Validate content type
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  # Validate filename
  validates_attachment_file_name :file, matches: [/png\Z/, /jpe?g\Z/i]

  process_in_background :file, only_process: [:medium]

  has_one :medium, as: :attachable
end
