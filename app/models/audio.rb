class Audio < ActiveRecord::Base
  include PaperClippable

  validates_attachment :subject, presence: true,
    size: {
      in: 0..61440.kilobytes,
      message: 'must be under 60MB in size.'
    },
    file_name: {
      matches: [
        /mp3\Z/,
        /ogg\Z/,
        /wav\Z/
      ],
      message:
        'needs to be one of these extensions: mp3, ogg, or wav.'
    },
    content_type: {
      content_type: [
        "application/octet-stream",
        "audio/mpeg",
        "audio/ogg",
        "audio/vnd.wave"
      ],
      message:
        'needs to be an audio file.'
    }
end
