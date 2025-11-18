#include "../Tools/roomParser.as"
var url = "https://media1.newcp.net/play/en/web_service/game_configs/rooms.json";
parseArray(url, function(result){
    _global.ROOMS_NEWCP = result;
});