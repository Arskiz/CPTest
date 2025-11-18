#include "../Tools/stampParser.as"
var stampUrl = "https://media1.newcp.net/play/en/web_service/game_configs/stamps.json";
parseArray(stampUrl, function(result){
    _global.STAMPS_NEWCP = result;
});