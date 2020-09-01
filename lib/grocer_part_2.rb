require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num] 
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[counter][:num]
        }
        cart.push(cart_item_with_coupon)
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1 
  end
  cart
end

def apply_clearance(cart)
  i = 0
  while i < cart.length
  if cart[i][:clearance]
    cart[i][:price] = (cart[i][:price] - (cart[i][:price] * 0.2)).round(2)
  end
  i += 1
  end
  cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  new_cart_w_coupons = apply_coupons(new_cart, coupons)
  final_cart = apply_clearance(new_cart_w_coupons)
  
  total = 0
  i = 0 
  while i < final_cart.length
   total += final_cart[i][:price] * final_cart[i][:count]
   i += 1
  end
   if total > 100
    return (total - (total * 0.1)) 
   end
  total
end
