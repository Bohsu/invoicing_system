root = exports ? this

$(document).ready ->
  # captcha image flush
  $("img[alt='captcha']").each (index, item) ->
    item.title = '看不清？点击刷新'
  $("img[alt='captcha']").bind 'click', (event) ->
    this.src = this.src + '?'

  # the close function for alert tip                                                                       
  $('button.close').bind 'click', (event) ->
    $(this).parent('.alert').remove()

