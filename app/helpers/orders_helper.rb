module OrdersHelper
  def get_product_info (line_item)
    product_id = line_item.product_id
    Product.where("id=?",product_id)[0]
  end
end