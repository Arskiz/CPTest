var stampUrl = "https://media.cpzero.net/play/en/web_service/game_configs/stamps.json";
if(_global.STAMPS_CPZ == undefined){
	_global.STAMPS_CPZ = [];
	parseStamp(stampUrl, function(result){
		_global.STAMPS_CPZ = result;
	});
}