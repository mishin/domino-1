# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130507234146) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["owner_id", "owner_type"], :name => "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], :name => "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], :name => "index_activities_on_trackable_id_and_trackable_type"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "clans", :force => true do |t|
    t.string   "type",       :default => "small"
    t.string   "name"
    t.integer  "g_rating",   :default => 500
    t.integer  "s_rating",   :default => 500
    t.integer  "leader_id"
    t.string   "avatar",     :default => "no_avatar_clan.jpg"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "glory",      :default => 0
  end

  create_table "countries", :force => true do |t|
    t.string  "iso"
    t.string  "name"
    t.string  "printable_name"
    t.string  "iso3"
    t.integer "numcode"
  end

  create_table "dashboard_comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.integer  "likes",      :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true
    t.datetime "closed_at"
    t.text     "likers"
    t.text     "dislikers"
    t.integer  "post_id"
  end

  create_table "dashboard_news", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.string   "header"
    t.integer  "likes",      :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true
    t.datetime "closed_at"
    t.text     "likers"
    t.text     "dislikers"
  end

  create_table "domino_games", :force => true do |t|
    t.string   "game_type"
    t.integer  "time_per_move", :default => 1
    t.integer  "winner_id"
    t.integer  "players_count", :default => 2
    t.datetime "finished_at"
    t.datetime "started_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "rating",        :default => 1200
    t.text     "data"
  end

  add_index "domino_games", ["game_type"], :name => "index_games_on_game_type"
  add_index "domino_games", ["players_count"], :name => "index_games_on_players_count"
  add_index "domino_games", ["rating"], :name => "index_games_on_rating"
  add_index "domino_games", ["time_per_move"], :name => "index_games_on_time_per_move"

  create_table "domino_games_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "domino_game_id"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "histories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "g_max_rating"
    t.integer  "s_max_rating"
    t.integer  "g_min_rating"
    t.integer  "g_best_won_from_player_id"
    t.integer  "s_best_won_from_player_id"
    t.integer  "g_worst_lost_from_player_id"
    t.integer  "s_worst_lost_from_player_id"
    t.integer  "g_a_lost",                    :default => 0
    t.integer  "s_a_lost",                    :default => 0
    t.integer  "g_a_won",                     :default => 0
    t.integer  "s_a_won",                     :default => 0
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "message"
    t.integer  "author_id"
    t.integer  "receiver_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "password"
    t.string   "email"
    t.string   "phone"
    t.integer  "tournament_id"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.boolean  "active",                              :default => false
    t.string   "gender",                 :limit => 1
    t.boolean  "is_admin",                            :default => false
    t.string   "avatar"
    t.string   "settings"
    t.integer  "g_rating",                            :default => 1200
    t.integer  "s_rating",                            :default => 1200
    t.datetime "last_seen_at"
    t.datetime "birth_date"
    t.string   "location"
    t.string   "country"
    t.string   "language"
    t.text     "about_me"
    t.string   "ip_address"
    t.string   "last_ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "provider"
    t.integer  "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "remember_me_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "guest"
    t.integer  "clan_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["g_rating"], :name => "index_users_on_g_rating"
  add_index "users", ["s_rating"], :name => "index_users_on_s_rating"

end
