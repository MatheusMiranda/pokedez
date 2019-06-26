class Pokemon < ApplicationRecord
  has_attached_file \
    :photo,
    styles: { thumb: ['32x32#', 'jpg'] },
    convert_options: {
      all: '-interlace Plane'
    },
    default_url: '/images/default_:style_photo.png'

  validates_attachment_presence :photo
  validates_attachment_file_name :photo, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/]
  validates :name, :presence => true, uniqueness: true

  def as_json(_opts = {})
    {
      id: id,
      name: name,
      types: types,
      photo: {
       url: photo.url,
      }
    }
  end
end
