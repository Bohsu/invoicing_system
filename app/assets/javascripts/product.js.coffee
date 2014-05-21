root = exports ? this

$(document).ready ->
  $('#product_buy_price, #product_sell_price, #product_quantity').on 'blur', (event) ->
    buy_total = $('#product_buy_price').val()
    sell_total = $('#product_sell_price').val()
    quantity = $('#product_quantity').val()
    $('#product_buy_total_price').val(buy_total * quantity)
    $('#product_sell_total_price').val(sell_total * quantity)
    


