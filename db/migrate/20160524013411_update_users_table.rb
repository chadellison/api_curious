class UpdateUsersTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :followers
      t.string :following
      t.string :starred
    end
  end
end
