class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title, null: false
      t.integer :year

      t.timestamps null: false
    end
  end

  def down
    drop_table :books
  end
end
