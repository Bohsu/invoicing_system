//= require jquery
//= require jquery_ujs

/*替换全部字符*/
String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
  if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
    return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")), replaceWith);
  } else {
    return this.replace(reallyDo, replaceWith);
  }
}

$(function() {
  // 判断空 $.isBlank($(this).val())
  $.isBlank = function(obj) {
    return(!obj || $.trim(obj) === "");
  };

  // 所有表单防止多次提交
  //$("form").submit(function(){
  // $(":submit",this).attr("disabled","disabled");
  //});

  // 级联下拉框
  $('select.multi-level').live('change', function() {
    $selector = $(this);

    $('#' + $selector.attr("aim_id")).val($selector.val());

    if (!$.isBlank($selector.attr("text_id"))) {
      $('#' + $selector.attr("text_id")).val($selector.find("option:selected").text());
    }

    $.ajax({
      type: "get",
      url: '/dynamic_selects?id=' + $selector.val() + '&otype=' + $selector.attr("otype") + '&aim_id=' + $selector.attr("aim_id") + '&text_id=' + encodeURI($selector.attr("text_id")),
      beforeSend: function(XMLHttpRequest) {
        $selector.nextAll('select').remove();
      },
      success: function(data, textStatus) {
        if (data.length > 0) {
          $selector.nextAll('select').remove();
          // $selector.parent().append(data);
          $selector.after(data);
        }
      },
      complete: function(XMLHttpRequest, textStatus) {
          //HideLoading();
      },
      error: function() {
          //请求出错处理
      }
    });
  });

  // 日期时间控件
  $('.my97_time').click(function() {
    WdatePicker({dateFmt:'yyyyMMdd'});
  });

  $('.my97_date').click(function() {
    WdatePicker({dateFmt:'yyyy-MM-dd'});
  });

  $('.my97_full_time').click(function() {
    WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});
  });

  // 下拉选择框
  $(".drop_select").live("click", function() {
    drop_select(this, $(this));
  });

  // 验证用户输入跳转页是否有效
  $(".jump_check").click(function () {
    var jump_page = $(".jump_num").val().trim();
    if (jump_page == '' || jump_page < 1 ) {
      alert('请输入有效数字！');
    } else {
      var url_str = window.location.search;
      if(url_str == '') {
        self.location = '?page=' + jump_page;
      }else {
        url_str = url_str.split('?');
        url_str = url_str[1];
        var url_ar = url_str.split('&');
        page_in_there = false;
        for(var i = 0; i < url_ar.length; i ++ ){
          i_get = url_ar[i].split('=');
          if (i_get[0] == 'page') {
            i_get[1] = jump_page;
            page_in_there = true;
          }
          url_ar[i] = i_get.join('=');
        }
        url_new = '?' + url_ar.join('&');

        if (page_in_there) {
          self.location = url_new;
        } else {
          self.location = url_new + '&page=' + jump_page;
        }
      }
    }
  })

  // 搜索框默认字的处理
  // $('#k').click(function(){
  //     text = $(this).val();
  //     if (text == '请输入您要搜索的关键词'){
  //       $(this).val('')
  //     }
  // });
  // $('#k').blur(function(){
  //   text = $(this).val();
  //   if (text == ''){
  //     $(this).val('请输入您要搜索的关键词')
  //   }
  // })

});

// 自动适应高度textarea
function textarea_auto_height(textarea){
  textarea.style.height = "1px";
  textarea.style.height = (25+textarea.scrollHeight)+"px";
}


function select_all_records()
{
  if ($('#select_all').get(0).checked)
  {
    $('input[type="checkbox"]').attr('checked', true)
  }
  else
  {
    $('input[type="checkbox"]').attr('checked', false)
  }
}

function open_new_window(url) {
  window.open(url,
    null, "location=no,menubar=no,toolbar=no,height=500,width=800,resizable=yes,scrollbars=1")
}


// 弹出框展示图片
function art_image_show(image_path){
  art.dialog({
    title: '图片',
    content: "<img width='600px;' src='"+image_path+"'/>",
    ok: function(){
      this.close();
      return false;
     }
  });
}

