class Chemical < ApplicationRecord
  belongs_to :user
  has_many :company_chemicals, dependent: :destroy
  has_many :companies, through: :company_chemicals

  validates :chemical_name, presence: true
  validates :synonym, presence: true
  validates :cas, presence: true
  validates :user_id, presence: true
end
