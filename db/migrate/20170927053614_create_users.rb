class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password 
      t.string :encrypted_confirm_password
      t.integer :mobile

      t.timestamps
    end
  end
end
