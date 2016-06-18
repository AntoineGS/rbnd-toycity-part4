require_relative 'udacidata'

class Product < Udacidata
  attr_reader :id, :price, :brand, :name

  def initialize(opts={})

    # Get last ID from the database if ID exists
    get_last_id
    # Set the ID if it was passed in, otherwise use last existing ID
    @id = opts[:id] ? opts[:id].to_i : @@count_class_instances
    # Increment ID by 1
    auto_increment if !opts[:id]
    # Set the brand, name, and price normally
    @brand = opts[:brand]
    @name = opts[:name]
    @price = opts[:price]
  end

  def update(options={})
    @price = options[:price] if options[:price]
    @brand = options[:brand] if options[:brand]
    @name = options[:name] if options[:name]
    Product.destroy(@id)
    Product.create(id: @id, brand: @brand, name: @name, price: @price)
    self
  end

  private
    # Reads the last line of the data file, and gets the id if one exists
    # If it exists, increment and use this value
    # Otherwise, use 0 as starting ID number
    def get_last_id
      last_id = File.exist?(@@data_path) ? CSV.read(@@data_path).last[0].to_i + 1 : nil
      @@count_class_instances = last_id || 0
    end

    def auto_increment
      @@count_class_instances += 1
    end

  public
    create_finder_methods(Product.new.instance_variables)
end
