class CartItemsController < ApplicationController

  def cart_items(discount=nil)
    if discount.present?
      binding.pry
    end
    @cart = session[:cart_items]
    @discount = session[:discount] unless session[:discount].nil?
    @cashback = session[:cashback] unless session[:cashback].nil?
  end

  def index

  end

  def add_to_cart
    product_id = params[:product_id]
    product = Product.find(product_id)
    product.quantity -= 1
    product.save!

    existing_product = session[:cart_items].detect {|f| f[:product_id] == product_id }

    if existing_product
      existing_product[:quantity] += 1
    else
      session[:cart_items] << {product_id: product_id, name: product.name, unit_cost: product.unit_cost, quantity: 1 }
    end
    redirect_to action: 'cart_items'
  end

  def remove_from_cart
    product_id = params[:product_id]
    product = Product.find(product_id)
    product.quantity += 1
    product.save!

    existing_product = session[:cart_items].detect {|f| f[:product_id] == product_id }

    if existing_product[:quantity] > 1
      existing_product[:quantity] -= 1
    else
      session[:cart_items].delete_if { |hash| (hash[:product_id] == existing_product[:product_id]) }
    end
    redirect_to action: 'cart_items'
  end

  private

  def checkout_params
    # params.require(:cart_item)
  end

end
