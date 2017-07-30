class CreateMasseges < ActiveRecord::Migration[5.1]
  def change
    create_table :masseges do |t|
      t.string :title
      t.text :content
      t.references :blog, foreign_key: true  

      t.timestamps
    end
  end
end
