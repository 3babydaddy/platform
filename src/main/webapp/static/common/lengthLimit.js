//在IE8下对textarea的字数长度限制的函数
		function isMaxLen(o){
			var nMaxLen=o.getAttribute ? parseInt(o.getAttribute("maxlength")) : "";  
			if(o.getAttribute && o.value.length>nMaxLen){  
				o.value=o.value.substring(0,nMaxLen)  
			}
		}