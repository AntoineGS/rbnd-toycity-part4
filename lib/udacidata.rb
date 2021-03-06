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
      products.push(create(id: line[0], brand: line[1],
                           name: line[2], price: line[3]))
    end
    products
  end

  def self.first(number = 1)
    number==1 ? all.first : all.take(number)
  end

  def self.last(number = 1)
    number==1 ? all.last : all.pop(number)
  end

  def self.find(id)
    object = nil
    raise ProductNotFoundError, "Exception Raised: Product not found" unless object = all.find{|product| product.id == id}
    object
  end

  def self.destroy(id)
    products = all
      if !find(id).nil? then
        reject = nil
        reset_file
        CSV.open(@@data_path, "a+") do |csv|
          products.each do |product|
            product.id == id ? reject = product : csv <<
            [product.id, product.brand, product.name, product.price]
          end
        end
        reject
      end
  end

  def self.where(options={})
    case when options[:brand]
      all.select{|product| product.brand == options[:brand]}
    when options[:name]
      all.select{|product| product.name == options[:name]}
    when options[:price]
      all.select{|product| product.price == options[:price]}
    end
  end

  def self.reset_file
    CSV.open(@@data_path, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
    end
  end

  def update(options={})
    options.each do |key,value|
      self.instance_variable_set("@#{key}", value)
    end
    self.class.destroy(self.id)
    self.class.create(id: self.id, brand: self.brand, name: self.name, price: self.price)
    self
  end
end
