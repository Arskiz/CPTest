#include "../Tools/generalParser.as"
var url = "https://media1.newcp.net/play/en/web_service/game_configs/furniture_items.json";
if(_global.FURNITURE_ITEMS_NEWCP == undefined){
		_global.FURNITURE_ITEMS_NEWCP = [];
		parseArray(url, function(result){
		_global.FURNITURE_ITEMS_NEWCP = result;
	});
}
