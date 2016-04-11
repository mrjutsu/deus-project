class Teaching < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :favorites

  has_attached_file :document,
                    :url  => "/assets/documents/:id/:style/:basename.:extension",
                    :path => "/public/assets/teachings/documents/:id/:style/:basename.:extension",
                    :storage => :s3,
                    :s3_region => "us-west-2",
              :bucket => "deus-project",
              :s3_protocol => 'https'
  # validates_attachment_content_type :program, content_type: ['application/pdf']

end
