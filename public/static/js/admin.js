/**
 * 后台JS主入口
 */

var layer = layui.layer,
    element = layui.element(),
    laydate = layui.laydate,
    form = layui.form();

/**
 * AJAX全局设置
 */
$.ajaxSetup({
    type: "post",
    dataType: "json"
});

/**
 * 后台侧边菜单选中状态
 */
$('.layui-nav-item').find('a').removeClass('layui-this');
$('.layui-nav-tree').find('a[href*="' + GV.current_controller + '"]').parent().addClass('layui-this').parents('.layui-nav-item').addClass('layui-nav-itemed');

/**
 * 通用单图上传
 */
layui.upload({
    url: "/index.php/api/upload/upload",
    type: 'image',
    ext: 'jpg|png|gif|bmp',
    success: function (data) {
        if (data.error === 0) {
            document.getElementById('thumb').value = data.url;
        } else {
            layer.msg(data.message);
        }
    }
});

/**
 * 通用日期时间选择
 */
$('.datetime').on('click', function () {
    laydate({
        elem: this,
        format: 'YYYY-MM'
})
});

$('.date').on('click', function () {
    laydate({
        elem: this,
        format: 'YYYY-MM-DD'
    })
});
/**
 * 通用表单提交(AJAX方式)
 */
form.on('submit(*)', function (data) {
    $.ajax({
        url: data.form.action,
        type: data.form.method,
        data: $(data.form).serialize(),
        success: function (info) {
            if (info.code === 1) {
                setTimeout(function () {
                    location.href = info.url;
                }, 1000);
            }
            layer.msg(info.msg);
        }
    });

    return false;
});

/**
 * 通用批量处理（审核、取消审核、删除）
 */
$('.ajax-action').on('click', function () {
    var _action = $(this).data('action');
    layer.open({
        shade: false,
        content: '确定执行此操作？',
        btn: ['确定', '取消'],
        yes: function (index) {
            $.ajax({
                url: _action,
                data: $('.ajax-form').serialize(),
                success: function (info) {
                    if (info.code === 1) {
                        setTimeout(function () {
                            location.href = info.url;
                        }, 1000);
                    }
                    layer.msg(info.msg);
                }
            });
            layer.close(index);
        }
    });

    return false;
});

/**
 * 通用全选
 */
$('.check-all').on('click', function () {
    $(this).parents('table').find('input[type="checkbox"]').prop('checked', $(this).prop('checked'));
});

/**
 * 通用删除
 */
$('.ajax-delete').on('click', function () {
    var _href = $(this).attr('href');
    layer.open({
        shade: false,
        content: '确定删除？',
        btn: ['确定', '取消'],
        yes: function (index) {
            $.ajax({
                url: _href,
                type: "get",
                success: function (info) {
                    if (info.code === 1) {
                        setTimeout(function () {
                            location.href = info.url;
                        }, 1000);
                    }
                    layer.msg(info.msg);
                }
            });
            layer.close(index);
        }
    });

    return false;
});

/**
 * 清除缓存
 */
$('#clear-cache').on('click', function () {
    var _url = $(this).data('url');
    if (_url !== 'undefined') {
        $.ajax({
            url: _url,
            success: function (data) {
                if (data.code === 1) {
                    setTimeout(function () {
                        location.href = location.pathname;
                    }, 1000);
                }
                layer.msg(data.msg);
            }
        });
    }

    return false;
});
$('.cloth_num').click(function () {
    var obj=$(this).find(':checkbox');
    $(obj).each(function (i) {
        if($(this).is(':checked')){
            $v=$(this).attr('value');
          $('#num_'+$(this).attr('value')).css('display','block') ;
          $('#num_'+$(this).attr('value')).attr('name','consume['+$v+'][num]') ;
        }else{
            $('#num_'+$(this).attr('value')).css('display','none');
            $('#num_'+$(this).attr('value')).attr('name','') ;
        }
  })
});
$('.cloth_num').find('.layui-form-checkbox').addClass('addbill');

$('.recode').click(function(){
    var ids=new Array();
    var obj=$('.code').find(':checked');
   $(obj).each(function (i) {
       ids[i]=$(this).val();
   });
    if(ids){
        var ids_obj={};
        ids_obj.data=ids;
        $.ajax({
            'url':'sum',
            'data':ids_obj,
            'type':'POST',
            'success':function (res) {
               if(res.code==0){
                   layer.msg(res.msg);
               }else{
                    $('.sum').val(res.sum);
                    $('.balance').val(res.balance);
                    $('.totle').val(res.balance+res.sum);
               }
            }

        })
    }

});
