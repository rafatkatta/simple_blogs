class AddPublichedAtToMasseges < ActiveRecord::Migration[5.1]
  def change
    add_column :masseges, :publiched_at, :datetime
  end
end
