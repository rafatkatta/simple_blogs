class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthday
      t.string :birth_country
      t.string :birth_city
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
