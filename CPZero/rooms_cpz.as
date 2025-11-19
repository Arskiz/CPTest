#include "../Tools/roomParser.as"
var url = "https://media.cpzero.net/play/en/web_service/game_configs/rooms.json";
if(_global.ROOMS_CPZ == undefined){
	_global.ROOMS_CPZ = [];
	parseArray(url, function(result){
		_global.ROOMS_CPZ = result;
	});
}