<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="input" type="java.lang.String" required="true" description="文件名"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称（ID）"%>
<%@ attribute name="value" type="java.util.List" required="false" description="隐藏域值（ID）"%>
<%@ attribute name="labelName" type="java.lang.String" required="false" description="输入框名称（Name）"%>
<%@ attribute name="labelValue" type="java.lang.String" required="false" description="输入框值（Name）"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="树结构数据地址"%>
<%@ attribute name="checked" type="java.lang.Boolean" required="false" description="是否显示复选框，如果不需要返回父节点，请设置notAllowSelectParent为true"%>
<%@ attribute name="extId" type="java.lang.String" required="false" description="排除掉的编号（不能选择的编号）"%>
<%@ attribute name="isAll" type="java.lang.Boolean" required="false" description="是否列出全部数据，设置true则不进行数据权限过滤（目前仅对Office有效）"%>
<%@ attribute name="notAllowSelectRoot" type="java.lang.Boolean" required="false" description="不允许选择根节点"%>
<%@ attribute name="notAllowSelectParent" type="java.lang.Boolean" required="false" description="不允许选择父节点"%>
<%@ attribute name="module" type="java.lang.String" required="false" description="过滤栏目模型（只显示指定模型，仅针对CMS的Category树）"%>
<%@ attribute name="selectScopeModule" type="java.lang.Boolean" required="false" description="选择范围内的模型（控制不能选择公共模型，不能选择本栏目外的模型）（仅针对CMS的Category树）"%>
<%@ attribute name="allowClear" type="java.lang.Boolean" required="false" description="是否允许清除"%>
<%@ attribute name="allowInput" type="java.lang.Boolean" required="false" description="文本框可填写"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="smallBtn" type="java.lang.Boolean" required="false" description="缩小按钮显示"%>
<%@ attribute name="hideBtn" type="java.lang.Boolean" required="false" description="是否显示按钮"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否限制选择，如果限制，设置为disabled"%>
<%@ attribute name="dataMsgRequired" type="java.lang.String" required="false" description=""%>
<style type="text/css">
    /*a  upload */
    .a-upload {
        padding: 4px 10px;
        height: 20px;
        line-height: 20px;
        position: relative;
        cursor: pointer;
        color: #888;
        background: #fafafa;
        border: 1px solid #ddd;
        border-radius: 4px;
        overflow: hidden;
        display: inline-block;
        *display: inline;
        *zoom: 1
    }

    .a-upload  input {
        position: absolute;
        font-size: 100px;
        right: 0;
        top: 0;
        opacity: 0;
        filter: alpha(opacity=0);
        cursor: pointer
    }

    .a-upload:hover {
        color: #444;
        background: #eee;
        border-color: #ccc;
        text-decoration: none
    }
    .clearfix:after{
	    content:"";
	    display:table;
	    height:0;
	    visibility:both;
	    clear:both;
	}

	.clearfix{
	*zoom:1;    /* IE/7/6*/
	}

</style>
<script type="text/javascript">
    //上传文件
    function ${input}SelectAction(file){
    	  var fileId=file.id;
    	  var fileInput=$(file);
          $.ajaxFileUpload({
              url: '${ctx}/file/upFile', //用于文件上传的服务器端请求地址
              secureuri: false, //一般设置为false
              fileElementId: fileInput, //文件上传空间的id属性  <input type="file" id="file" name="file" />
              dataType: 'json', //返回值类型 一般设置为json
              type:"post",
              success: function(res){
                  if(res.success){
                      //返回路径
                      var returnPath=res.returnPath;
                      //展示名
                      var showName=res.showName;
                      $("#"+fileId+"Input").val(returnPath);
                      ${input}Preview(fileId);

                  }else{
                      var message = res.message;
                      alert(message);
                  }
              },
              error:function(data, status, e){

                flag=0;
                alert("上传文件失败！");
              }
          });
         return false;


    }
   //删除文件
    function ${input}Del(obj,fileId){
        var url = $(obj).prev().attr("url");
        $("#"+fileId+"Input").val($("#"+fileId+"Input").val().replace("|"+url,"","").replace(url+"|","","").replace(url,"",""));
        ${input}Preview(fileId);
    }
   //样式展示
    function ${input}Preview(fileId){
    	var li, urls = $("#"+fileId+"Input").val().split("|");
    		 $("#"+fileId+"Preview").children().remove();
    	        for (var i=0; i<urls.length; i++){
    	            if (urls[i]!=""){//<c:if test="${type eq 'thumb' || type eq 'images'}">
    	                li = "<li><img src=\""+urls[i]+"\" url=\""+urls[i]+"\" style=\"max-width:${empty maxWidth ? 200 : maxWidth}px;max-height:${empty maxHeight ? 200 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";//</c:if><c:if test="${type ne 'thumb' && type ne 'images'}">
    	                li = "<li><a title='"+decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/")+1))+"' href=\""+urls[i]+"\" url=\""+urls[i]+"\" target=\"_blank\">"+decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/")+1))+"</a>";//</c:if>
    	                li += "&nbsp;<c:if test="${!readonly}"><a href=\"javascript:\" onclick=\"${input}Del(this,'"+fileId+"');\">×</a></c:if></li>";
    	                $("#"+fileId+"Preview").append(li);
    	                $("#"+fileId+"Preview li:eq(0)>a").css({
    	                    "max-width" : "80%",
    	                    "display" : "inline-block",
    	                    "overflow" : "hidden",
    	                    "vertical-align" : "middle",
    	                    "text-overflow" : "ellipsis",
    	                    "white-space" : "nowrap"
    	                });
    	                $("#"+fileId+"ShowType").hide();
    	            }
    	        }
    	        if ($("#"+fileId+"Preview").text() == ""){
    	            $("#"+fileId+"ShowType").show();
    	        }



    }

    $(function(){
    	var divAttr=$('#${input}All').children('.officeDiv');
    	$.each(divAttr,function(i,e){
    		var id=$(e).find(".a-upload").find("input").attr("id");
    		 ${input}Preview(id);
    	});

    });
</script>
<div class="input-append"   id="${input}All" style="width:60%;">
         <c:forEach items="${value}" var="officeVar" varStatus="status">
            <c:if test="${(officeVar.office.id!=null&&officeVar.office.id!='')||(officeVar.office.name!=null&&officeVar.office.name!='')||(officeVar.filePath!=null&&officeVar.filePath!='') }">
                <div  class="officeDiv clearfix"  style="margin-left: 10px;">
                         <div style="float:left;width:20%;">
                             <input id="${id}Id${status.index}" name="${name}[${status.index}].office.id" class="${cssClass} idClass1" type="hidden" value="${officeVar.office.id }"/>
                             <input id="${id}inputName${status.index}" name="${name}[${status.index}].office.name" class="${cssClass}" type="hidden" value="${officeVar.office.name }" />
                             <span id="${id}Name${status.index}">${officeVar.office.name }</span>
                         </div>
                         <div style="float:left;width:70%;text-align: center">
                             <ol id="${input}zipFile${status.index}Preview" style="list-style-type:none;margin:0px;display: inline"></ol>
                             <input id="${input}zipFile${status.index}Input" name="${name}[${status.index}].filePath"   type="hidden" value="${officeVar.filePath }"/>
                             <a href="javascript:;" class="a-upload" id="${input}zipFile${status.index}ShowType" >
                             <input type="file" name="${input}zipFile${status.index}" id="${input}zipFile${status.index}"   onchange="${input}SelectAction(this)" />点击这里上传文件
                              </a>
                         </div>
                         <div style="float:left;width:10%; text-align: left;margin-bottom: 3px;">
                             <input  name="${name}[${status.index}].sort" type="hidden" value="${status.index}"  id="sortId" />
                             <input class="btn btn-primary" type="button" value="删除"  onclick="delOffice(this)">
                         </div>
                 </div>
            </c:if>
        </c:forEach>

        <input  class="btn btn-primary" type="button" value="添加" style="margin-left:85px;display: block;" id="${input}officeSelcet" onclick="${input}Add(this)">
</div>


<script type="text/javascript">
    //初始化顺序值
    j=$('.officeDiv').length;
    function delOffice(obj){
    	var td=$(obj);
        td.parents(".officeDiv").remove();
    }
	function ${input}Add(obj){

		// 是否限制选择，如果限制，设置为disabled
		if ($("#${id}Button").hasClass("disabled")){
			return true;
		}
		var backIds="";
        var idInput=$(obj).parents('.input-append').find(".idClass1");
        $.each(idInput,function(index,e){
            backIds+=$(e).val()+",";
        })
        backIds=backIds.substring(0,backIds.length-1);
		// 正常打开
		top.$.jBox.open(
			"iframe:${ctx}/tag/treeselect?url="+encodeURIComponent("${url}")+"&module=${module}&checked=${checked}&extId=${extId}&isAll=${isAll}",
			"选择${title}",
		    300,
		    420,
		    {
				ajaxData:{selectIds: backIds},
				buttons:{"确定":"ok", ${allowClear?"\"清除\":\"clear\", ":""}"关闭":true},
				submit:function(v, h, f){

					if (v=="ok"){
						var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
						var ids = [], names = [], nodes = [];
						if ("${checked}" == "true"){
							nodes = tree.getCheckedNodes(true);
						}else{
							nodes = tree.getSelectedNodes();
						}
						for(var i=0; i<nodes.length; i++) {//<c:if test="${checked && notAllowSelectParent}">
							if (nodes[i].isParent){
								continue; // 如果为复选框选择，则过滤掉父节点
							}//</c:if><c:if test="${notAllowSelectRoot}">
							if (nodes[i].level == 0){
								top.$.jBox.tip("不能选择根节点（"+nodes[i].name+"）请重新选择。");
								return false;
							}//</c:if><c:if test="${notAllowSelectParent}">
							if (nodes[i].isParent){
								top.$.jBox.tip("不能选择父节点（"+nodes[i].name+"）请重新选择。");
								return false;
							}//</c:if><c:if test="${not empty module && selectScopeModule}">
							if (nodes[i].module == ""){
								top.$.jBox.tip("不能选择公共模型（"+nodes[i].name+"）请重新选择。");
								return false;
							}else if (nodes[i].module != "${module}"){
								top.$.jBox.tip("不能选择当前栏目以外的栏目模型，请重新选择。");
								return false;
							}//</c:if>
							ids.push(nodes[i].id);
							names.push(nodes[i].name);
							//<c:if test="${!checked}">
							break; // 如果为非复选框选择，则返回第一个选择  </c:if>
						}
				        for(var i=0;i<ids.length;i++){
				        	if(backIds.indexOf(ids[i])!=-1){
                                continue;
                            }
				        var div='<div  class="officeDiv clearfix"  style="margin-left: 10px;">'+
						        	'<div style="float:left;width:20%;">'+
			                            '<input id="${id}Id'+j+'" name="${name}['+j+'].office.id" class="${cssClass} idClass1" type="hidden" />'+
			                            '<input id="${id}inputName'+j+'" name="${name}['+j+'].office.name" class="${cssClass}" type="hidden" />'+
			                            '<span id="${id}Name'+j+'"></span>'+
			                        '</div>'+
			                        '<div style="float:left;width:70%;text-align: center">'+
				                        '<ol id="${input}zipFile'+j+'Preview" style="list-style-type:none;margin:0px;display: inline"></ol>'+
			                            '<input id="${input}zipFile'+j+'Input" name="${name}['+j+'].filePath"   type="hidden"/>'+
			                            '<a href="javascript:;" class="a-upload" id="${input}zipFile'+j+'ShowType" >'+
			                            '<input type="file" name="${input}zipFile'+j+'" id="${input}zipFile'+j+'"   onchange="${input}SelectAction(this)" />点击这里上传文件'+
			                             '</a>'+
			                        '</div>'+
			                        '<div style="float:left;width:10%; text-align: left;margin-bottom: 3px;">'+
			                            '<input  name="${name}['+j+'].sort" type="hidden" value="'+j+'" />'+
			                            '<input class="btn btn-primary" type="button" value="删除"  onclick="delOffice(this)">'+
			                        '</div>'+
                            '</div>';
				        	$(obj).before(div);
				        	$("#${id}Id"+j+"").val(ids[i]);
				        	 $("#${id}inputName"+j+"").val(names[i]);
	                        $("#${id}Name"+j+"").text(names[i]);
	                        j++
				        }
				        top.$.jBox.close();
					}//<c:if test="${allowClear}">
					else if (v=="clear"){
						$("#${id}Id").val("");
						$("#${id}Name").text("");
						top.$.jBox.close();
	                }//</c:if>
					if(typeof ${id}TreeselectCallBack == 'function'){
						${id}TreeselectCallBack(v, h, f);
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			}
		);
	}
</script>