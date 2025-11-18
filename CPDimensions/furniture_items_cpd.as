#include "../Tools/generalParser.as"
var url = "https://vanilla.cpdimensions.com/play/en/web_service/game_configs/furniture_items.json";
if(_global.FURNITURE_ITEMS_CPD == undefined){
	parseArray(url, function(result){
		_global.FURNITURE_ITEMS_CPD = result;
	});
}
