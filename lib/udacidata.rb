require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create(attributes = nil)
  # If the object's data is already in the database
  # create the object
  # return the object
  product = self.new(attributes)
  save(product)
  product
  # If the object's data is not in the database
  # create the object
  # save the data in the database
  # return the object
  end

  def self.save(product)
    CSV.open(@@data_path, "a+") do |csv|
      csv << [product.id, product.brand, product.name, product.price]
    end
  end

  def self.all
    CSV.read(@@data_path).each do |line|
      puts line
    end
  end
end
