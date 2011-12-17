class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    drop_table :sessions
    change_table :users do |t| 
      t.remove :persistence_token
      t.remove :login_count
      t.remove :failed_login_count
      t.remove :last_request_at
      t.remove :current_login_at
      t.remove :last_login_at
      t.remove :current_login_ip
      t.remove :last_login_ip
      t.remove :site_admin
      t.string :encrypted_password,:null => false, :default => '', :limit => 128
      t.string :password_salt,:null => false, :default => ''
      t.rememberable
      t.trackable

    end 
    #
    add_index :users, :login,:unique => true

  end

  def self.down
    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end
    add_index :sessions, :session_id
    add_index :sessions, :updated_at

    change_table :users do |t|
      t.string  :persistence_token
      t.integer :login_count, :null => false, :default => 0
      t.integer :failed_login_count, :null=>false, :default => 0
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string  :current_login_ip
      t.string  :last_login_ip
      t.boolean :site_admin
      t.remove :encrypted_password
      t.remove :password_salt
      t.remove :remember_token
      t.remove :remember_created_at
      t.remove :sign_in_count
      t.remove :current_sign_in_at
      t.remove :last_sign_in_at
      t.remove :current_sign_in_ip
      t.remove :last_sign_in_ip
    end
  end
end
