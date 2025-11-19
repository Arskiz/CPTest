var url = "https://vanilla.cpdimensions.com/play/en/web_service/game_configs/rooms.json";
if(_global.ROOMS_CPD == undefined){
	_global.ROOMS_CPD = [];
	parseRoom(url, function(result){
		_global.ROOMS_CPD = result;
	});
}
