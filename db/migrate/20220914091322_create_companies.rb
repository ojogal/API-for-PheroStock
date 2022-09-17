class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
