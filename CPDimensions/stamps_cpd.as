#include "../Tools/stampParser.as"
var url = "https://vanilla.cpdimensions.com/play/en/web_service/game_configs/stamps.json";
parseArray(url, function(result){
    _global.STAMPS_CPD = result;
});