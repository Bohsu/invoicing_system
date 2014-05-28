root = exports ? this

$(document).ready ->
  $('#select_customer').on 'click', (event) ->
    art.dialog({ id: "customer", content: document.getElementById("no_form_#{ cg }") })
    
  $('#sell_product_price, #sell_product_quantity').on 'blur', (event) ->
    price = $('#sell_product_price').val()
    count = $('#sell_product_quantity').val() 
    $('#sell_product_total_price').val(price * count)

  $("#sell_form_submit").on 'click', (event) ->
  	customer_id = $("#sell_customer_id").val()
  	if customer_id == ""
       alert("请查询您要添加的客户!")
       return false
       
  $("#sell_product_form_submit").on 'click', (event) ->
  	product_id = $("#sell_product_product_id").val()
  	if product_id == ""
       alert("请查询您要添加的商品!")
       return false