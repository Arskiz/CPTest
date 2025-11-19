function parseRoom(url, callback) {
    var lv = new LoadVars();
    lv.onData = function(raw) {
        // Poista BOM
        raw = raw.split("\ufeff").join("");
        
        // Kerää kaikki room-objektit
        var allRooms = [];
        
        // Etsi kaikki objektit (ohita uloin {})
        var pos = raw.indexOf("{");
        pos++; // Ohita ensimmäinen {
        
        while (pos < raw.length) {
            // Etsi seuraava "numero": { 
            var idStart = raw.indexOf('"', pos);
            if (idStart == -1) break;
            
            var idEnd = raw.indexOf('"', idStart + 1);
            if (idEnd == -1) break;
            
            // Tarkista että seuraava on :
            var colonPos = raw.indexOf(":", idEnd);
            if (colonPos == -1 || colonPos > idEnd + 5) {
                pos = idEnd + 1;
                continue;
            }
            
            // Etsi objektin alku
            var objStart = raw.indexOf("{", colonPos);
            if (objStart == -1) break;
            
            // Etsi objektin loppu
            var bracketCount = 1;
            var objEnd = objStart + 1;
            while (bracketCount > 0 && objEnd < raw.length) {
                if (raw.charAt(objEnd) == '{') bracketCount++;
                if (raw.charAt(objEnd) == '}') bracketCount--;
                objEnd++;
            }
            
            var objStr = raw.substring(objStart + 1, objEnd - 1);
            
            // Parsaa objekti
            var obj = {};
            
            // Split by komma, mutta varo sisäkkäisiä objekteja
            var pairs = [];
            var currentPair = "";
            var depth = 0;
            for (var i = 0; i < objStr.length; i++) {
                var c = objStr.charAt(i);
                if (c == '{' || c == '[') depth++;
                if (c == '}' || c == ']') depth--;
                
                if (c == ',' && depth == 0) {
                    pairs.push(currentPair);
                    currentPair = "";
                } else {
                    currentPair += c;
                }
            }
            if (currentPair != "") pairs.push(currentPair);
            
            for (var i = 0; i < pairs.length; i++) {
                var pair = pairs[i];
                var colonPos2 = pair.indexOf(":");
                if (colonPos2 == -1) continue;
                
                var key = pair.substring(0, colonPos2).split('"').join('').split(' ').join('');
                var val = pair.substring(colonPos2 + 1);
                
                // Poista lainausmerkit ja trim
                val = val.split('"').join('');
                while (val.charAt(0) == ' ') val = val.substring(1);
                while (val.charAt(val.length - 1) == ' ') val = val.substring(0, val.length - 1);
                
                // Yritä numeroida
                if (val == "true") {
                    obj[key] = true;
                } else if (val == "false") {
                    obj[key] = false;
                } else if (val == "null") {
                    obj[key] = null;
                } else if (!isNaN(Number(val)) && val != "") {
                    obj[key] = Number(val);
                } else {
                    obj[key] = val;
                }
            }
            
            allRooms.push(obj);
            pos = objEnd;
        }
        
        callback(allRooms);
    };
    
    lv.load(url);
}