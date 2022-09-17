class CompanySerializer
  include JSONAPI::Serializer
  attributes :company_name
  
  belongs_to :user
  has_many :chemicals
end
