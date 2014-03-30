class Video < ActiveRecord::Base
  has_attached_file :file,
                    styles: {
                      medium: { eometry: "640x480", format: 'mp4' },
                      thumb: { geometry: "100x100#", format: 'jpg', time: 1 }
                    },
                    path: '/system/:class/:attachment/:id_partition/:style/:hash',
                    url: '/system/:class/:attachment/:id_partition/:style/:hash',
                    default_url: '/images/:style/missing.png',
                    hash_secret: 'HiperMegaSecretString',
                    storage: :dropbox,
                    dropbox_credentials: Rails.root.join('config/dropbox.yml'),
                    processors: [:ffmpeg]

  # Validate content type
  validates_attachment_content_type :video, :content_type => ['video/avi','video/mpe?g4?']

  # Validate filename
  validates_attachment_file_name :video, :matches => [/mpe?g4?\Z/, /avi\Z/]

  process_in_background :file, only_process: [:medium]

  has_one :medium, as: :attachable
end
