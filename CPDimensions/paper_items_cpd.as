#include "../Tools/generalParser.as"
var url = "https://vanilla.cpdimensions.com/play/en/web_service/game_configs/paper_items.json";
if(_global.PAPER_ITEMS_CPD == undefined){
	parseArray(url, function(result){
		_global.PAPER_ITEMS_CPD = result;
	});
}
