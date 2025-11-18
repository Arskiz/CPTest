#include "../Tools/stampParser.as"
var stampUrl = "https://media.cpzero.net/play/en/web_service/game_configs/stamps.json";
parseArray(stampUrl, function(result){
    _global.STAMPS_CPZ = result;
});