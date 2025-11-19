var stampUrl = "https://media1.newcp.net/play/en/web_service/game_configs/stamps.json";
if(_global.STAMPS_NEWCP == undefined){
	_global.STAMPS_NEWCP = [];
	parseStamp(stampUrl, function(result){
    	_global.STAMPS_NEWCP = result;
	});
}
