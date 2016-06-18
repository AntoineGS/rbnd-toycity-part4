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

  def count_by_brand(products)
    brand_summary=Hash.new
    products.each do |product|
      if brand_summary.keys.include?(product.brand)
        brand_summary[product.brand]=+1
      else brand_summary[product.brand]=1
      end
    end
    brand_summary
  end
end
