/**
 * jquery插件
 * 
 * @param $
 */
(function($) {
    var TfkjTable = function (options) {
        this.options = options;
    }
    
    TfkjTable.DEFAULTS={
        pagination : true,
        paginationDetailHAlign : 'right',
        paginationHAlign : 'left',
        paginationPreText : '上一页',
        paginationNextText : '下一页',
        sidePagination : 'server',
        clickToSelect : false,
        cache:false,
        pageSize : 10,
        pageNumber : 1
    }

    TfkjTable.prototype.delRow = function (params) {
        var rows=this.getSelections(),
            ids=[],
            i = 0;
        if(rows!=null && rows.length>0){
            for (; i < rows.length; i++) {
                ids.push(rows[i].id);
            }
            new jBox('Confirm', {
                title:'系统提示',
                content: '您确认要删除这些数据么？',
                confirmUrl:params.url+ids,
                confirmTable:this,
                confirm:function(){
                    $.ajax({
                        url : this.confirmUrl,
                        confirmTable:this.confirmTable,
                        type : "post",
                        async : false,
                        dataType : "json",
                        success : function(data) {
                            if(data===1){
                                new jBox('Notice', {
                                    content: '删除成功！',
                                    color: 'green',
                                    autoClose: 3000
                                });
                                this.confirmTable.refresh();
                            }else{
                                new jBox('Notice', {
                                    content: '删除失败:可能存在不能删除的数据！',
                                    color: 'red',
                                    autoClose: 3000
                                });
                                this.confirmTable.refresh();
                            }
                        }
                    });
                }
            }).open();
        }else{
            new jBox('Notice', {
                content: '请选择您要删除的数据！',
                color: 'red',
                autoClose: 3000
            });
        } 
    }
    
    var allowedMethods = ['delRow'];
    
    $.fn.tfkjTable = function (option) {
        var value,
            args = Array.prototype.slice.call(arguments, 1);

        this.each(function () {
            var $this = $(this),
                data = $this.data('bootstrap.table'),
                tfkjData = $this.data('tfkj.table'),
                options = $.extend({}, TfkjTable.DEFAULTS, $this.data(),
                    typeof option === 'object' && option);

            if (typeof option === 'string') {
                if ($.inArray(option, $.fn.bootstrapTable.methods) >= 0) {
                    if (!data) {
                        return;
                    }
                    value = data[option].apply(data, args);
                    if (option === 'destroy') {
                        $this.removeData('tfkj.table');
                        $this.removeData('bootstrap.table');
                    }
                }else if($.inArray(option, allowedMethods) >= 0){
                    if (!tfkjData) {
                        return;
                    }
                    value = tfkjData[option].apply(data, args);
                }else{
                    throw new Error("Unknown method: " + option);
                }
            }

            if (!data) {
                $this.data('tfkj.table', (new TfkjTable(options)));
                $this.bootstrapTable(options);
            }
        });

        return typeof value === 'undefined' ? this : value;
    };
})(jQuery);