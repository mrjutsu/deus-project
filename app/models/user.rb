class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook]

  has_many :teachings
  has_many :comments
  has_many :favorites
  has_many :corrections

  has_many :teachings_approvals
  has_many :approved_teachings, through: :teachings_approvals

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", small: "30x30>" },
                    :url  => "/assets/users/avatars/:id/:style/:filename.:extension",
                    :path => "/public/assets/users/avatars/:id/:style/:filename.:extension",
                    :storage => :s3,
                    :s3_region => "us-west-2",
              :bucket => "deus-project",
              :s3_protocol => 'https'
 	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates_with AttachmentSizeValidator, attributes: :avatar, :less_than => 2.megabytes

  enum role: [:normal,:editor,:admin,:super_admin]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.avatar = auth.info.image if auth.info.image?
      user.confirmed_at = Time.now
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def full_name
    if self.first_name.nil? && self.last_name.nil?
      'Nombre no disponible'
    else
      self.first_name + ' ' + self.last_name
    end
  end

end
