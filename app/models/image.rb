class Image < ActiveRecord::Base
  include PaperClippable

  validates_attachment :subject, presence: true,
    size: {
      in: 0..20480.kilobytes,
      message: 'must be under 20MB in size.'
    },
    file_name: {
      matches: [
        /gif\Z/,
        /png\Z/,
        /jpe?g\Z/
      ],
      message:
        'needs to be one of these extensions: png, gif, or jp(e)g.'
    }
end
