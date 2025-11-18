#include "../Tools/roomParser.as"
var url = "https://media.cpzero.net/play/en/web_service/game_configs/rooms.json";
parseArray(url, function(result){
    _global.ROOMS_CPZ = result;
});