var WebConstant = (function() { 
// Private static attributes.
var constants = {
		/**
		 * 处分问责模块纪律处分字段公务员事业单位人员和国有企业人员不涉及的码值
		 */
		SELECTION_CFWZ_JLCF_GWY_CODEVALUE : "w",//纪律处分字段公务员、事业单位人员和国有企业人员选项码值，“w”表示不涉及
		/**
		 * 业务管理模块全局是、否、不涉及、空选项的码值
		 */
		SELECTION_YWGL_GLOBAL_Y : "Y",//是
		SELECTION_YWGL_GLOBAL_N : "N",//否
		SELECTION_YWGL_GLOBAL_W : "w",//不涉及
		SELECTION_YWGL_GLOBAL_EMPTY : "0000",//空
}

		return {
			getConstant:function(name){
				return constants[name];
			}
		}
})();

/*用法：
var k=WebConstant.getConstant('YWGL');
alert(k);*/