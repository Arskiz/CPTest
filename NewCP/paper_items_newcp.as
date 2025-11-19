#include "../Tools/generalParser.as"
var url = "https://media1.newcp.net/play/en/web_service/game_configs/paper_items.json";
if(_global.PAPER_ITEMS_NEWCP == undefined){
	_global.PAPER_ITEMS_NEWCP = [];
	parseArray(url, function(result){
		_global.PAPER_ITEMS_NEWCP = result;
	});
}