function parseArray(url, callback){
	var lv = new LoadVars();
	lv.onData = function(raw) {
		if(raw == undefined){
            callback(null);
            return;
        }
		
		// Poista BOM
		raw = raw.split("\ufeff").join("");
		
		// Poista kaikki lainausmerkit
		raw = raw.split('"').join('');
		
		// Kerää kaikki stamp-objektit kaikista kategorioista
		var allStamps = [];
		
		// Etsi kaikki "stamps:[" kohdat
		var searchPos = 0;
		while (searchPos < raw.length) {
			var stampsStart = raw.indexOf("stamps:[", searchPos);
			if (stampsStart == -1) break;
			
			// Etsi tämän stamps-arrayn loppu
			var arrayStart = stampsStart + 8; // "stamps:[".length
			var bracketCount = 1;
			var arrayEnd = arrayStart;
			
			while (bracketCount > 0 && arrayEnd < raw.length) {
				if (raw.charAt(arrayEnd) == '[') bracketCount++;
				if (raw.charAt(arrayEnd) == ']') bracketCount--;
				arrayEnd++;
			}
			
			// Nyt meillä on stamps-array
			var stampsStr = raw.substring(arrayStart, arrayEnd - 1);
			
			// Parsaa kaikki objektit tästä arraysta
			var pos = 0;
			while (pos < stampsStr.length) {
				var objStart = stampsStr.indexOf("{", pos);
				if (objStart == -1) break;
				
				var objEnd = stampsStr.indexOf("}", objStart);
				if (objEnd == -1) break;
				
				var objStr = stampsStr.substring(objStart + 1, objEnd);
				
				// Parsaa objekti
				var obj = {};
				var pairs = objStr.split(",");
				
				for (var i = 0; i < pairs.length; i++) {
					var pair = pairs[i];
					var colonPos = pair.indexOf(":");
					if (colonPos == -1) continue;
					
					var key = pair.substring(0, colonPos).split('"').join('').split(' ').join('');
					var val = pair.substring(colonPos + 1);
					
					// Poista lainausmerkit ja VAIN alku/loppuvälilyönnit
					val = val.split('"').join('');
					// Trim (poista vain alusta ja lopusta)
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
				
				allStamps.push(obj);
				pos = objEnd + 1;
			}
			
			searchPos = arrayEnd;
		}
		
		callback(allStamps);
	};
	
	lv.load(url);
}