class UpdateUserLogin < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :login
    end
  end
end
