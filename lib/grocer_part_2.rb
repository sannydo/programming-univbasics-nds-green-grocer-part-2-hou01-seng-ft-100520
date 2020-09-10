require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
 #needs to create a new cart with all of the coupons in it
 counter = 0
 while counter < coupons.length
  #must add a second argument, cart because ultimately we want to see if the coupons are in the cart
  
  cart_item = find_item_by_name_in_collection(coupons[counter][:item],cart)
   couponed_item_name ="#{coupons[counter][:item]} W/COUPON"
   
  #set up a variable, check if the item with coupon is already in the cart then we would just increase the count
  
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart) 
  
  #so cart_item is everything in the cart so just the variable cart_item will tell us if the item is in the cart
  if cart_item && cart_item[:count] >= coupons[counter][:num]
   if cart_item_with_coupon  
     cart_item_with_coupon[:count] += coupons[counter][:num]
     cart_item[:count] -= coupons[counter][:num]
   else
     cart_item_with_coupon = {
       :item => couponed_item_name,
       :price => coupons[counter][:cost] / coupons[counter][:num],
       :count => coupons[counter][:num],
       :clearance => cart_item[:clearance]
     }
     cart << cart_item_with_coupon
     cart_item[:count] -= coupons[counter][:num]
   end
  end
  counter += 1
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
