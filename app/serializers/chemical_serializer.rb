class ChemicalSerializer
  include JSONAPI::Serializer
  attributes :chemical_name, :synonym, :cas

  belongs_to :user
  has_many :companies
end
