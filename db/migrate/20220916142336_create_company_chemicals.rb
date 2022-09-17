class CreateCompanyChemicals < ActiveRecord::Migration[7.0]
  def change
    create_table :company_chemicals do |t|
      t.belongs_to :company, null: false, foreign_key: true
      t.belongs_to :chemical, null: false, foreign_key: true

      t.timestamps
    end
  end
end
