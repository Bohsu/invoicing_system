root = exports ? this

$(document).ready ->
  $('#select_supplier').on 'click', (event) ->
    art.dialog({ id: "supplier", content: document.getElementById("no_form_#{ cg }") })
    
  $('#buy_product_price, #buy_product_quantity').on 'blur', (event) ->
    price = $('#buy_product_price').val()
    count = $('#buy_product_quantity').val() 
    $('#buy_product_total_price').val(price * count)