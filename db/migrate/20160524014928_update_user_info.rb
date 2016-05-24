class UpdateUserInfo < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :followers
      t.remove :following
      t.remove :starred
      t.string :followers_url
      t.string :following_url
      t.string :starred_url
    end
  end
end
