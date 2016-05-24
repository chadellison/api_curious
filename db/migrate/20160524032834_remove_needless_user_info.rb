class RemoveNeedlessUserInfo < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :screen_name
      t.remove :followers_url
      t.remove :following_url
      t.remove :starred_url
    end
  end
end
