<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="input" type="java.lang.String" required="true" description="文件名"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="类型"%>
<%@ attribute name="leftText2" type="java.lang.String" required="false" description="左侧字体显示2"%>
<%@ attribute name="leftText3" type="java.lang.String" required="false" description="左侧字体显示3"%>
<%@ attribute name="isBorder" type="java.lang.String" required="false" description="是否控制边框颜色"%>
<%@ attribute name="rightText1" type="java.lang.String" required="false" description="右侧侧字体显示1"%>
<%@ attribute name="rightText2" type="java.lang.String" required="false" description="右侧字体显示2"%>
<%@ attribute name="isShowRightText1" type="java.lang.String" required="false" description="是否显示右侧侧字体显示1"%>
<%@ attribute name="isShowRightText2" type="java.lang.String" required="false" description="是否显示右侧字体显示2"%>
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
        color: white;
        background: #e35827;;
        border: 1px solid #ddd;
        border-radius: 4px;
        overflow: hidden;
        display: inline-block;
        *display: inline;
        *zoom: 1
    }
    .qtupload {
        padding: 4px 10px;
        height: 20px;
        line-height: 20px;
        position: relative;
        cursor: pointer;
        color: white;
        background: #e35827;;
        border: 1px solid #ddd;
        border-radius: 4px;
        overflow: hidden;
        display: inline-block;
        *display: inline;
        *zoom: 1
    }
    .qtupload:hover {
        color: white;
        background: #e35827;
        border-color: #e35827;
        text-decoration: none
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
        color: white;
        background: #e35827;
        border-color: #e35827;
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
	li {
	    line-height: 35px;
	}
</style>
<script type="text/javascript">
    //上传文件
    function ${input}SelectAction(file,flag){
    	debugger;
    	  var fileId=file.id;
    	  var fileInput=$(file);
    	  var dqInput=$(file).parent().prev("."+fileId+"Input");
    	  var dqName=dqInput.attr("name").substring(0,dqInput.attr("name").indexOf("."));
          var dqOl=dqInput.prev("ol");
          var dqA=$(file).parent();
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
                      var newTime=res.newTime
                      //展示名
                      var dqInputVal=dqInput.val();
                      if(dqInputVal!=null&&dqInputVal!=''){
                    	  dqInputVal=dqInputVal+"|"+returnPath;
                      }else{
                    	  dqInputVal=returnPath;
                      }
                      dqInput.val(dqInputVal);
                      var showName=res.showName;
                      var i=j-1;
                      var scTime= '<div style="margin-top:8px">'+
				                      '<span>上传日期</span>'+
				                      "<input type='text' style='width:125px;margin-left:14px' name='"+dqName+".in0005' value='"+newTime.toString()+"' class='scTime'   " +
				                      "' onfocus='" +
				                      'WdatePicker({startDate:"%y-%M-01 00:00",dateFmt:"yyyy-MM-dd HH:mm",alwaysUseStartDate:true})' +
				                      "'/> "+
				                  '</div>';
                      if(flag==1){
                          dqInput.parents('.fj').next('.time').children('.scTimeDiv').append(scTime);
                      }
                      if('${isBorder}'==1){
                    	  dqA.parents('.benjieCon').css("border",
                          "2px solid red");
                      }
                      ${input}Preview(fileId,dqInput,dqOl,dqA);

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
        var dqInput=$(obj).parent().parent().next();
        var dqOl=$(obj).parent().parent();
        var dqA=$(obj).parent().parent().next().next();
        if('${isBorder}'==1){
            dqInput.parents('.benjieCon').css("border",
            "2px solid red");
        }
        dqInput.parents('.fj').next('.time').children('.scTimeDiv').find("Div:last-child").remove();
        dqInput.val(dqInput.val().replace("|"+url,"","").replace(url+"|","","").replace(url,"",""));
        ${input}Preview(fileId,dqInput,dqOl,dqA);

    }
   //样式展示
    function ${input}Preview(fileId,dqInput,dqOl,dqA){
    	  var li, urls =dqInput.val().split("|");
          dqOl.children().remove();
    	        for (var i=0; i<urls.length; i++){
    	            if (urls[i]!=""){//<c:if test="${type eq 'thumb' || type eq 'images'}">
    	                li = "<li><img src=\""+urls[i]+"\" url=\""+urls[i]+"\" style=\"max-width:${empty maxWidth ? 200 : maxWidth}px;max-height:${empty maxHeight ? 200 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";//</c:if><c:if test="${type ne 'thumb' && type ne 'images'}">
    	                li = "<li><a title='"+decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/")+1))+"' href=\""+urls[i]+"\" url=\""+urls[i]+"\" target=\"_blank\">"+decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/")+1))+"</a>";//</c:if>
    	                li += "&nbsp;<c:if test="${!readonly}"><a href=\"javascript:\" onclick=\"${input}Del(this,'"+fileId+"');\">×</a></c:if></li>";
    	                dqOl.append(li);
    	                dqOl.children("li").children("a").css({
    	                    "max-width" : "80%",
    	                    "display" : "inline-block",
    	                    "overflow" : "hidden",
    	                    "vertical-align" : "middle",
    	                    "text-overflow" : "ellipsis",
    	                    "white-space" : "nowrap",
    	                });
    	            }
    	        }



    }

    $(function(){
    	var divAttr=$('#${input}All').children('.officeDiv');
    	$.each(divAttr,function(i,e){
    		var id=$(e).find(".a-upload").find("input").attr("id");
    		var ids=$(e).find(".a-upload")
            $.each(ids,function(i,inpuEle){
            	var fileId=$(inpuEle).find("input").attr("id");
                var dqInput=$(inpuEle).prev("."+fileId+"Input");
                var dqOl=dqInput.prev("ol");
                var dqA=$(inpuEle);
               ${input}Preview(fileId,dqInput,dqOl,dqA);
            })
    	});

    });
</script>
<!-- 上面js为附件上传 -->
<!-- 反显值 -->
<div class="input-append"   id="${input}All" style="width:80%;">
         <c:forEach items="${value}" var="officeVar" varStatus="status">
            <c:if test="${officeVar.type!=null&&officeVar.type!='' }">
                 <div  class="officeDiv clearfix"  style="margin-left: 10px;">
                                    <div style="float:left;width:15%;">
                                         <div  style="height: 35px;line-height: 35px;">
                                         <input  name="${name}[${status.index}].type" value="${officeVar.type}" class="${cssClass}" type="hidden" />
                                         <c:if test="${type=='2' }">
                                             <input id="${id}Id${status.index}" name="${name}[${status.index}].officeId"  value="${officeVar.officeId}" class="${cssClass} idClass" type="hidden" />
                                             <input id="${id}inputName${status.index}" name="${name}[${status.index}].officeNames" value="4{officeVar.officeNames}" class="${cssClass}" type="hidden" />
                                              <span id="${id}Name${status.index}">${officeVar.officeNames}</span>
                                         </c:if>
                                           <c:if test="${type=='1' }">
                                             <input id="${id}Id${status.index}" name="${name}[${status.index}].leaderId" value="${officeVar.leaderId}" class="${cssClass} idClass" type="hidden" />
                                             <input id="${id}inputName${status.index}" name="${name}[${status.index}].leaderNames"  value="${officeVar.leaderNames}" class="${cssClass}" type="hidden" />
                                             <span id="${id}Name${status.index}">${officeVar.leaderNames}</span>
                                         </c:if>

                                         </div>
                                        <div style="height: 35px;line-height: 35px;">
                                        <span >${leftText2}</span>
                                        </div>
                                        <div style="height: 35px;line-height: 35px;">
                                        <span >${leftText3}</span>
                                        </div>

                                    </div>
                                    <div style="float:left;width:45%;text-align: left" class="fj">
                                        <div style="height: 35px;line-height: 35px;">
                                        <a class="qtupload"    onclick="delOffice(this)">删除</a>
                                        </div>
                                        <div style="height: 35px;line-height: 35px;">
                                            <select name="${name}[${status.index}].in0002" style="width:137px; margin-bottom: 10px;">
                                            <option value="01" <c:if test="${officeVar.in0002=='01'}">selected="selected"</c:if>>办理中</option>
                                            <option value="02" <c:if test="${officeVar.in0002=='02'}">selected="selected"</c:if>>已办结</option>
                                            <option value="03" <c:if test="${officeVar.in0002=='03'}">selected="selected"</c:if>>已转办</option>
                                            </select>
                                        </div>
                                        <div style="">
                                            <ol id="${input}zipFile${status.index}Preview" style="list-style-type:none;margin:0px;display: inline"></ol>
                                            <input class="${input}zipFile${status.index}Input" name="${name}[${status.index}].filePath"  value="${officeVar.filePath}"   type="hidden"/>
                                            <a href="javascript:;" class="a-upload" id="${input}zipFile${status.index}ShowType" >
                                            <input type="file" name="${input}zipFile${status.index}" id="${input}zipFile${status.index}"   onchange="${input}SelectAction(this,'1')" />上传
                                             </a>
                                        </div>
                                    </div>
                                    <div style="float:left;width:35%; text-align: left;margin-bottom: 3px;" class="time">
                                            <input  name="${name}[${status.index}].sort" value="${officeVar.sort}" type="hidden" value="${status.index}" />
                                            <div style="height: 35px;line-height: 35px;">
                                                <div style="display: ${isShowRightText1};">
                                                  <span>${rightText1}</span>
                                                  <span style="margin-left: 10px;">${officeVar.in0001}</span>
                                                </div>

                                          </div>
                                            <div style="height: 35px;line-height: 35px;">
                                                  <div style="display: ${isShowRightText2?'block':'none'}" >
                                                     <span>${rightText2}</span>
                                                    <select name="${name}[${status.index}].in0003" style="width:137px;margin-left:10px;margin-bottom: 10px;">
                                                        <option value="01" <c:if test="${officeVar.in0003=='01'}">selected="selected"</c:if>>否</option>
                                                        <option value="02" <c:if test="${officeVar.in0003=='02'}">selected="selected"</c:if>>是</option>
                                                        </select>
                                                    </div>
                                          </div>
                                        <div style="" class="scTimeDiv">
                                        <c:set var="stringList" value="${fn:split(officeVar.in0005,',')}" />
                                            <c:forEach items="${stringList}" var="scTimeList" >
                                                <c:if test="${scTimeList!=null  && scTimeList!='' }">
	                                                <div style="margin-top:8px">
	                                                      <span>上传日期</span>
	                                                      <input type='text' style='width:125px;margin-left:10px' name='${name}[${status.index}].in0005' value='${scTimeList }' class='scTime'  onfocus='WdatePicker({startDate:"%y-%M-01 00:00",dateFmt:"yyyy-MM-dd HH:mm",alwaysUseStartDate:true})' />
	                                                  </div>
                                                </c:if>

                                            </c:forEach>

                                        </div>
                                    </div>
                           </div>
                           <div  class="officeDiv clearfix"  style="margin-left: 10px;">
                                <div style="float:left;width:15%;">
                                    <span >落实及上报情况</span>
                                </div>
                                <div style="float:left;width:80%;">
                                   <textarea style="width:85%" rows="3" cols="90" name="${name}[${status.index}].in0004">${officeVar.in0004}</textarea>
                                </div>
                            </div>
                            <hr  class="hr">
            </c:if>
        </c:forEach>
        <a class="qtupload"  style="margin-left:10px;" id="${input}officeSelcet" onclick="${input}Add(this)">添加</a>

</div>


<script type="text/javascript">
    //初始化顺序值
    j=$('.officeDiv').length;
    function delOffice(obj){
    	if('${isBorder}'==1){
            $(obj).parents('.benjieCon').css("border",
            "2px solid red");
        }
    	var td=$(obj);
        td.parents(".officeDiv").next().next(".hr").remove();
        td.parents(".officeDiv").next("div").remove();
        td.parents(".officeDiv").remove();

    }
	function ${input}Add(obj){
		// 是否限制选择，如果限制，设置为disabled
		if ($("#${id}Button").hasClass("disabled")){
			return true;
		}
		var backIds="";
		var idInput=$(".idClass");
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
						        	'<div style="float:left;width:15%;">'+
							        	 '<div  style="height: 35px;line-height: 35px;">'+
							        	 '<input  name="${name}['+j+'].type" value="${type}" class="${cssClass}" type="hidden" />'+
							        	 //<c:if test="${type=='2' }">
							        	     '<input id="${id}Id'+j+'" name="${name}['+j+'].officeId" class="${cssClass}  idClass"   type="hidden" />'+
							        	     '<input id="${id}inputName'+j+'" name="${name}['+j+'].officeNames" class="${cssClass}" type="hidden" />'+
							        	 //</c:if>
							        	   //<c:if test="${type=='1' }">
                                             '<input id="${id}Id'+j+'" name="${name}['+j+'].leaderId" class="${cssClass} idClass" type="hidden" />'+
                                             '<input id="${id}inputName'+j+'" name="${name}['+j+'].leaderNames" class="${cssClass}" type="hidden" />'+
                                         //</c:if>
	                                     '<span id="${id}Name'+j+'"></span>'+
	                                     '</div>'+
			                            '<div style="height: 35px;line-height: 35px;">'+
			                            '<span >${leftText2}</span>'+
			                            '</div>'+
			                            '<div style="height: 35px;line-height: 35px;">'+
			                            '<span >${leftText3}</span>'+
                                        '</div>'+

			                        '</div>'+
			                        '<div style="float:left;width:45%;text-align: left" class="fj">'+
	                                    '<div style="height: 35px;line-height: 35px;">'+
	                                    '<a class="qtupload"    onclick="delOffice(this)">删除</a>'+
	                                    '</div>'+
	                                    '<div style="height: 35px;line-height: 35px;">'+
		                                    '<select name="${name}['+j+'].in0002" style="width:137px; margin-bottom: 10px;">'+
	                                        '<option value="01" >办理中</option>'+
	                                        '<option value="02">已办结</option>'+
	                                        '<option value="03">已转办</option>'+
	                                        '</select>'+
	                                    '</div>'+
                                        '<div style="">'+
	                                        '<ol id="${input}zipFile'+j+'Preview" style="list-style-type:none;margin:0px;display: inline"></ol>'+
	                                        '<input class="${input}zipFile'+j+'Input" name="${name}['+j+'].filePath"   type="hidden"/>'+
	                                        '<a href="javascript:;" class="a-upload" id="${input}zipFile'+j+'ShowType" >'+
	                                        '<input type="file" name="${input}zipFile'+j+'" id="${input}zipFile'+j+'"   onchange="${input}SelectAction(this,'+'1'+')" />上传'+
	                                         '</a>'+
                                        '</div>'+
			                        '</div>'+
			                        '<div style="float:left;width:35%; text-align: left;margin-bottom: 3px;" class="time">'+
				                            '<input  name="${name}['+j+'].sort" type="hidden" value="'+j+'" />'+
				                            '<div style="height: 35px;line-height: 35px;">'+
		                                        '<div style="display: ${isShowRightText1};">'+
		                                          '<span>${rightText1}</span>'+
		                                          '<span></span>'+
		                                        '</div>'+

		                                  '</div>'+
				                            '<div style="height: 35px;line-height: 35px;">'+
						                          '<div style="display: '+
						                             "${isShowRightText2?'block':'none'}"+
				                                         '">'+
				                                     '<span>${rightText2}</span>'+
			                                        '<select name="${name}['+j+'].in0003" style="width:137px;margin-left:10px;margin-bottom: 10px;">'+
			                                            '<option value="01">否</option>'+
			                                            '<option value="02">是</option>'+
				                                        '</select>'+
				                                    '</div>'+
	                                      '</div>'+
			                            '<div style="" class="scTimeDiv">'+
	                                    '</div>'+
			                        '</div>'+
                            '</div>'+
                            '<div  class="officeDiv clearfix"  style="margin-left: 10px;">'+
	                            '<div style="float:left;width:15%;">'+
	                                '<span >落实及上报情况</span>'+
	                            '</div>'+
	                            '<div style="float:left;width:80%;">'+
	                               '<textarea   style="width:85%" rows="3" cols="90" name="${name}['+j+'].in0004"></textarea>'+
                                '</div>'+
                            '</div>'+
                            '<hr  class="hr">';
				        	$(obj).before(div);
				        	$("#${id}Id").val(ids.join(",").replace(/u_/ig,""));
				        	$("#${id}Id"+j+"").val(ids[i]);
				        	 $("#${id}inputName"+j+"").val(names[i]);
	                        $("#${id}Name"+j+"").text(names[i]);
	                        j++
	                        if('${isBorder}'==1){
	                        	$(obj).parents('.benjieCon').css("border",
	                            "2px solid red");
	                        }
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