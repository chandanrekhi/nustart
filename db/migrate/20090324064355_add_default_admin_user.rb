class AddDefaultAdminUser < ActiveRecord::Migration
  def self.up
    admin = Manager.create(:email=>"admin@admin.com", :password => "admin123", :password_confirmation=>"admin123", :name=>"Admin123")
    admin.activation_code = nil
    admin.activated_at = Time.now
    admin.save!
  end

  def self.down
    # admin = Manager.find_by_name("Admin")
    # admin.destroy
  end
end
