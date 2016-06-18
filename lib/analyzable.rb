module Analyzable
  def average_price(products)
    sum = 0
    products.each{|product| sum += product.price.to_f}
    (sum/products.length).round(2)
  end

  def print_report(products)

  end
end
