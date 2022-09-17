class UserSerializer
  include JSONAPI::Serializer
  attributes :email

  has_many :companies
  has_many :chemicals
end
