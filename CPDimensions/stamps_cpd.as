var url = "https://vanilla.cpdimensions.com/play/en/web_service/game_configs/stamps.json";
if(_global.STAMPS_CPD == undefined){
	_global.STAMPS_CPD = [];
	parseStamp(url, function(result){
		_global.STAMPS_CPD = result;
	});
}
