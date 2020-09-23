
require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  counter = 0
  coupons.each do |coupon|
    item_in_cart = find_item_by_name_in_collection(coupon[:item], cart)
    cart_item_w_coupon = find_item_by_name_in_collection(coupon[:item] + " W/COUPON", cart)
    if cart_item_w_coupon && item_in_cart[:count] >= coupon[:num]
        cart_item_w_coupon[:count] += coupon[:num]
        item_in_cart[:count] -= coupon[:num]
       elsif item_in_cart && item_in_cart[:count] >= coupon[:num]
        cart << {
          :item => coupon[:item] + " W/COUPON",
          :price => coupon[:cost] / coupon[:num],
          :count => coupon[:num],
          :clearance => item_in_cart[:clearance]
        }
        item_in_cart[:count] -= coupon[:num]
    end
  end
  cart
end





def apply_clearance(cart)
  counter = 0
  while counter < cart.length
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
    end
    counter += 1
  end
  cart
end




def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart,coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total = 0
  counter = 0
  while counter < final_cart.length
    total += final_cart[counter][:price] * final_cart[counter][:count]
  counter += 1
  end
  if total > 100
    total -= (total * 0.10)
  end
  total
end
