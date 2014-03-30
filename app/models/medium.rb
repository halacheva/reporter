class Medium < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true, dependent: :destroy
  belongs_to :report
  acts_as_list scope: :report

  attr_accessor :file

  before_save :distribute_media

  private

  def distribute_media
    if file && file.content_type
      type = check_media_type(file.content_type.downcase)
      if type
        self.attachable = type.create(file: file)
      end
    end
  end

  def check_media_type(content_type)
    return Video if /video/.match(content_type)
    return Image if /image/.match(content_type)
  end
end
