class CreateChemicals < ActiveRecord::Migration[7.0]
  def change
    create_table :chemicals do |t|
      t.string :chemical_name
      t.string :synonym
      t.string :cas
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
