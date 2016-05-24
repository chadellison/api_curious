class RemoveGithubToken < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :github_token
    end
  end
end
