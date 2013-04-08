class GamesUsers < ActiveRecord::Migration
  def up
    create_table :games_users, :id => false do |t|
      t.references :user
      t.references :game
      t.timestamps
    end
  end

  def down
  end
end