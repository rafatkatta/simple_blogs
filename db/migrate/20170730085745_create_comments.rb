class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :massege, foreign_key: true
      t.references :commentator, foreign_key: true    

      t.timestamps
    end
  end
end
