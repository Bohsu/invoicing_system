root = exports ? this

$(document).ready ->
  # $('#select_supplier').on 'click', (event) ->
  #   art.dialog({ id: "supplier", content: document.getElementById("no_form_#{ cg }") })
    
  $('#buy_product_price, #buy_product_quantity').on 'blur', (event) ->
    price = $('#buy_product_price').val()
    count = $('#buy_product_quantity').val() 
    $('#buy_product_total_price').val(price * count)

  $("#buy_form_submit").on 'click', (event) ->
  	supplier_id = $("#buy_supplier_id").val()
  	if supplier_id == ""
       alert("请查询您要添加的供应商!")
       return false
       
  $("#buy_product_form_submit").on 'click', (event) ->
  	product_id = $("#buy_product_product_id").val()
  	if product_id == ""
       alert("请查询您要添加的商品!")
       return false
       