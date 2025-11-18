function parseArray(url, callback){
    var lv = new LoadVars();
    lv.onData = function(raw) {
        if(raw == undefined){
            callback(null);
            return;
        }
        
        // Remove BOM
        raw = raw.split("\ufeff").join("");
        
        // Create the array
        var items = [];
        
        // Locate all objects
        var pos = 0;
        while (pos < raw.length) {
            var start = raw.indexOf("{", pos);
            if (start == -1) break;
            
            // Find MATCHING closing brace by counting brackets
            var bracketCount = 1;
            var end = start + 1;
            while (bracketCount > 0 && end < raw.length) {
                if (raw.charAt(end) == '{') bracketCount++;
                if (raw.charAt(end) == '}') bracketCount--;
                end++;
            }
            end--; // Go back to the actual } position
            
            var objStr = raw.substring(start + 1, end);
            
            // Parse object - split by comma BUT respect nesting
            var obj = {};
            var pairs = [];
            var currentPair = "";
            var depth = 0;
            
            for (var i = 0; i < objStr.length; i++) {
                var c = objStr.charAt(i);
                
                // Track depth
                if (c == '{' || c == '[') depth++;
                if (c == '}' || c == ']') depth--;
                
                // Only split on comma at depth 0
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
                var colonPos = pair.indexOf(":");
                if (colonPos == -1) continue;
                
                var key = pair.substring(0, colonPos).split('"').join('').split(' ').join('');
                var val = pair.substring(colonPos + 1);
                
                // Remove quotes and trim (keep spaces INSIDE values)
                val = val.split('"').join('');
                while (val.charAt(0) == ' ') val = val.substring(1);
                while (val.charAt(val.length - 1) == ' ') val = val.substring(0, val.length - 1);
                
                // Try to numerate
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
            
            items.push(obj);
            
            // CRITICAL FIX: Start searching AFTER the opening brace, not after closing
            pos = start + 1;
        }
        
        callback(items);
        
    };
    
    lv.load(url);
}