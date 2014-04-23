require 'active_support/concern'

module PaperClippable
  extend ActiveSupport::Concern

  included do
    has_one :discussion, as: :content, dependent: :destroy

    has_attached_file :subject,
      storage: :s3,
      bucket: ENV.fetch('S3_BUCKET_NAME'),
      s3_credentials: {
        access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
        secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY')
      }
  end
end
