require_relative './config/db.rb'

DB.create_table :avatars do
  primary_key :id
  String :status
  String :name
  String :file_url
end
