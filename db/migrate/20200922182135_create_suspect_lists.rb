class CreateSuspectLists < ActiveRecord::Migration[5.2]
  def change
    create_table :suspect_lists do |t|
      t.string :name
      t.string :file
      t.string :delimiter
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
