class CreateContactAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_addresses do |t|
      t.string :city
      t.string :street
      t.decimal :number
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
