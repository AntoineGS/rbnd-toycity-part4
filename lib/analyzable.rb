module Analyzable
  def average_price(products)
    sum = 0
    products.each{|product| sum += product.price.to_f}
    (sum/products.length).round(2)
  end

  def print_report(products)
    products.each do |product|
      return "ID: #{product.id}, Product: #{product.name}, Brand: #{product.brand}, Price: #{product.price}"
    end
  end

  def count_by_brand

  end
end
