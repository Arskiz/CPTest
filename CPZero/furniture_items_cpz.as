#include "../Tools/generalParser.as"
var url = "https://media.cpzero.net/play/en/web_service/game_configs/furniture_items.json";
if(_global.FURNITURE_ITEMS_CPZ == undefined){
		_global.FURNITURE_ITEMS_CPZ = [];
		parseArray(url, function(result){
		_global.FURNITURE_ITEMS_CPZ = result;
	});
}
