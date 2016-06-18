module Analyzable
  def average_price(products)
    sum = 0
    products.each{|product| sum += product.price.to_f}
    (sum/products.length).round(2)
  end

  def print_report(products)
    output = String.new
    output << "Average Price: #{average_price(products)}\n"
    output << "Inventory by Brand:\n"
    count_by_brand(products).each do |key,qty|
      output << "  - #{key}: #{qty}\n" end
    output << "Inventory by Name:\n"
    count_by_name(products).each do |key,qty|
      output << "  - #{key}: #{qty}\n" end
    output
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

  def count_by_name(products)
    name_summary=Hash.new
    products.each do |product|
      if name_summary.keys.include?(product.name)
        name_summary[product.name]=+1
      else name_summary[product.name]=1
      end
    end
    name_summary
  end

end
