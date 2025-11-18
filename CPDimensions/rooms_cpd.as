#include "../Tools/roomParser.as"
var url = "https://vanilla.cpdimensions.com/play/en/web_service/game_configs/rooms.json";
if(_global.ROOMS_CPD == undefined){
	parseArray(url, function(result){
		_global.ROOMS_CPD = result;
	});
}
