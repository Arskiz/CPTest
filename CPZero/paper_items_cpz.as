#include "../Tools/generalParser.as"
var url = "https://media.cpzero.net/play/en/web_service/game_configs/paper_items.json";
parseArray(url, function(result){
    _global.PAPER_ITEMS_CPZ = result;
});