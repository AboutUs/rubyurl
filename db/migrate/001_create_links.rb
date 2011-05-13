class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.column "website_url", :string
      t.column "token",       :string
      t.column "permalink",   :string
      t.column "ip_address",  :string
      t.column "created_at",  :datetime
      t.column "updated_at",  :datetime
    end

    add_index :links, :token
    add_index :links, :website_url
  end

  def self.down
    drop_table :links
  end
end
