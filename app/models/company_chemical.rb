class CompanyChemical < ApplicationRecord
  belongs_to :company, inverse_of: :company_chemicals
  belongs_to :chemical
end
