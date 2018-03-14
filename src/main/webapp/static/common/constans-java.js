var JavaConstant = (function() {
// Private static attributes.
var constants = {
		

		 MODULE_NAME_NO_BLOOD : "影响任用",// 影响任用
}

		return {
				getConstant:function(name){
					return constants[name];
					}
				}
})();

/*用法：
var k=JavaConstant.getConstant('YWGL');
alert(k);*/

