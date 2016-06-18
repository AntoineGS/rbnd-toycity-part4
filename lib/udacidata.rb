require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create(attributes = nil)
    product = self.new(attributes)
    file = CSV.read(@@data_path)
    save(product) unless file.assoc(product.id.to_s)
    product
  end

  def self.save(product)
    CSV.open(@@data_path, "a+") do |csv|
      csv << [product.id, product.brand, product.name, product.price]
    end
  end

  def self.all
    file = CSV.read(@@data_path)
    products=[]
    file.drop(1).each do |line|
      products.push(create(id: line[0], brand: line[1], name: line[2], price: line[3]))
    end
    products
  end

  def self.first(number = 1)
    number==1 ? all.first : all.take(number)
  end

  def self.last(number = 1)
    number==1 ? all.last : all.pop(number)
  end
end
