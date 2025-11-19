var url = "https://media1.newcp.net/play/en/web_service/game_configs/rooms.json";
if(_global.ROOMS_NEWCP == undefined){
	_global.ROOMS_NEWCP = [];
	parseRoom(url, function(result){
    _global.ROOMS_NEWCP = result;
});
}
