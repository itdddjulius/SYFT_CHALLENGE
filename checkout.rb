# ==============================================================================
# MODULE : checkot.rb
#
# AUTHOR : Julius Olatokunbo
#
# WRITTEN: THR-03-SEP-2020
#
# REASON : 
#
#           Our marketing team want to offer promotions as an incentive for our customers to purchase these items.
#
#           If you spend over £60, then you get 10% of your purchase
#           If you buy 2 or more lavender hearts then the price drops to £8.50.
#           Our check-out can scan items in any order, and because our promotions 
#           will change, it needs to be flexible regarding our promotional rules.
#
#           The interface to our checkout looks like this (shown in Ruby):
#
#           co = Checkout.new(promotional_rules)
#           co.scan(item)
#           co.scan(item)
#           price = co.total
#
#           Implement a checkout system that fulfills these requirements.
#           Test data
#           ---------
#           Basket: 001,002,003
#           Total price expected: £66.78
#
#           Basket: 001,003,001
#           Total price expected: £36.95
#
#           Basket: 001,002,001,003
#           Total price expected: £73.76
#
#           --------------------------------------------
#
# ==============================================================================


#
# Product code  | Name                   | Price
# ----------------------------------------------------------
# 001           | Lavender heart         | £9.25
# 002           | Personalised cufflinks | £45.00
# 003           | Kids T-shirt           | £19.95
#


$end_of_checkout = false
$shopping_basket_value = 0
$product_count1 = 0
$product_count2 = 0
$product_count3 = 0
$total_items = 0
$numstr2 = nil



  def _clear_screen
   if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
      system('cls')
    else
      system('clear')
   end
  end
  
  def _basket
        x = 0 
        while x <= $numstr2.count 
            case
                when $numstr2[x] == 1 then $shopping_basket_value = $shopping_basket_value + _scan(1) # JO-04SEP2020- co.scan(item)
                when $numstr2[x] == 2 then $shopping_basket_value = $shopping_basket_value + _scan(2) # JO-04SEP2020- co.scan(item)
                when $numstr2[x] == 3 then $shopping_basket_value = $shopping_basket_value + _scan(3) # JO-04SEP2020- co.scan(item)
            end
            x = x + 1
        end
        #           If you spend over £60, then you get 10% of your purchase
        if $shopping_basket_value > 60
        then
            $shopping_basket_value = $shopping_basket_value - (0.1 * $shopping_basket_value)
        end
        _items
  end

  def _scan( itm )
    case
        when itm == 1 then 
            $product_count1 = $product_count1 + 1 
            #           If you buy 2 or more lavender hearts then the price drops to £8.50.
            if $product_count1 >= 2
            then
                return 8.5
            else
                return 9.25
            end
        when itm == 2 then 
            $product_count2 = $product_count2 + 1 
            return 45
        when itm == 3 then 
            $product_count3 = $product_count3 + 1 
            return 19.95 
    end
  end
  
  def _checkout( str, str2)  
        while $end_of_checkout == false
            case
                when str == "EMPTY" then _empty
                when str == "EMP" then _empty
                when str == "RESET" then _reset
                when str == "RST" then _reset
                when str == "ITEMS" then _items
                when str == "ITM" then _items
                when str == "BASKET" then _basket
                when str == "BSK" then _basket
                when str == "SCAN" then _scan
                when str == "SCN" then _scan
                when str == "TOTAL" then _total
                when str == "TOT" then _total
                when str == "PRICES" then _prices
                when str == "PRC" then _prices
                when str == "FIN" then _fin
                when str == "END" then _fin
            end
            _shopping
        end
  end

  def _items
     puts "---YOUR SHOPPING BASKET---"
     puts "Total Items = " + $total_items.to_s
     puts "Basket Value = " + $shopping_basket_value.to_s
     puts "----------------------------------------"
  end

  def _prices
    puts "---OUR CURRENT PRICELIST---"
    puts "001 Lavender heart 9.25"
    puts "002 Personalised cufflinks 45.00"
    puts "003 Kids T-shirt 19.95"
    puts "----------------------------------------"
  end

  def _shopping
    if $end_of_checkout == false
    then 
        _get_usr_input
    else
        exit
    end
  end

  def _get_usr_input
     str = ""
     str2 = ""
     puts  "Enter Shopping Action (EMPTY, BASKET, SCAN, TOTAL, ITEMS, FIN -or- END)"
     str = gets.chomp().upcase
     if str == "BASKET" or str == "BSK" or str == "SCAN" or str == "SCN"
     then
        puts  "Enter Items (e.g 001,002,003,003,004 etc)"  # JO-04SEP2020- New Items Added to Shopping Basket
        str2 = gets.chomp().upcase
        $numstr2 = str2.scan(/\d+/).map(&:to_i) #=> [num1, num2, num3, ... ]

        print "You Entered = "
        x = 0 
        while x <= $numstr2.count - 1 
            print $numstr2[x].to_s + ", "
            x = x + 1
        end
        puts $numstr2[x].to_s

        $total_items = $total_items + $numstr2.count # JO-04SEP2020 - TOTAL ITEMS = TOTAL ITEMS + ( NEW ITEMS)

        if str == "" and str2 == ""
            puts  "Shopping Is Over Thank You" 
        end
     end
     _checkout(str, str2)
  end

  def _fin
    puts  "Shopping Is Over Thank You"
    $end_of_checkout = true
  end


  def _reset
    $end_of_checkout = false
    $shopping_basket_value = 0
    $product_count1 = 0
    $product_count2 = 0
    $product_count3 = 0
    $total_items = 0
    $numstr2 = nil
  end

  def _empty
    _reset
    _prices
    _items
  end  

  _reset
  _clear_screen
  _checkout("BEGIN", "NOW")



