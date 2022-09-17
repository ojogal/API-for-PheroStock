class Company < ApplicationRecord
  belongs_to :user
  has_many :company_chemicals, dependent: :destroy
  has_many :chemicals, through: :company_chemicals

  validates :company_name, :user_id, presence: true
end
