class Document < ActiveRecord::Base
  include PaperClippable

  validates_attachment :subject, presence: true,
    size: {
      in: 0..20480.kilobytes,
      message: 'must be under 20MB in size.'
    },
    file_name: {
      matches: [
        /xlsx?\Z/,
        /te?xt\Z/,
        /rtf\Z/,
        /pptx?\Z/,
        /keynote\Z/,
        /pages\Z/,
        /numbers\Z/,
        /pdf\Z/,
        /docx?\Z/
      ],
      message:
        'needs to be one of these extensions: pdf, doc(x), xls(x), t(e)xt, ppt(x), rtf, keynote, pages, or numbers.'
    }
end
