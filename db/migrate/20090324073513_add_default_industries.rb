class AddDefaultIndustries < ActiveRecord::Migration
  def self.up
    Industry.create(:name => "Automotive", :description => "Automobiles - Cars, Motorcycles, cycles, auto parts and components, spare parts, automobile lubricants and oils, etc")
    Industry.create(:name => "Energy, Resources and Materials", :description => "Chemicals, Electric power, Environment, Oil and gas, Steel")
    Industry.create(:name => "Financial Services", :description => "Banking, Insurance, Investment, Securities")
    Industry.create(:name => "Food and Agriculture", :description => "Food and Agriculture")
    Industry.create(:name => "Health Care", :description => "Hospitals, Pharmaceuticals, Health Insurance, Beauty products")
    Industry.create(:name => "High Tech", :description => "Software and Hardware")
    Industry.create(:name => "Media and Entertainment", :description => "Radio, TV, and Publishing")
    Industry.create(:name => "Non Profit", :description => "Philanthrophy")
    Industry.create(:name => "Public Sector", :description => "Education, Government")
    Industry.create(:name => "Retail and Consumer Goods", :description => "FMCG, Fashion")
    Industry.create(:name => "Telecommunications", :description => "Broadband, Mobile, Phone")
    Industry.create(:name => "Transportation", :description => "Airlines, Cargo, Logistics, Supple Chain etc")
  end

  def self.down
    Industry.find(:all).each { |i| i.destroy }
  end
end
