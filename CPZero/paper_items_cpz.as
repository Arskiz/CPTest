#include "../Tools/generalParser.as"
var url = "https://media.cpzero.net/play/en/web_service/game_configs/paper_items.json";
if(_global.PAPER_ITEMS_CPZ == undefined){
	_global.PAPER_ITEMS_CPZ = [];
	parseArray(url, function(result){
		_global.PAPER_ITEMS_CPZ = result;
	});
}
