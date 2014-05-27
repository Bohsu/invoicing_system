root = exports ? this

$(document).ready ->
  $('#select_customer').on 'click', (event) ->
    art.dialog({ id: "customer", content: document.getElementById("no_form_#{ cg }") })
    
  $('#sell_product_price, #sell_product_quantity').on 'blur', (event) ->
    price = $('#sell_product_price').val()
    count = $('#sell_product_quantity').val() 
    $('#sell_product_total_price').val(price * count)