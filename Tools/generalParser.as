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
			
			var end = raw.indexOf("}", start);
			if (end == -1) break;
			
			var objStr = raw.substring(start + 1, end);
			
			// Parse object
			var obj = {};
			var pairs = objStr.split(",");
			
			for (var i = 0; i < pairs.length; i++) {
				var pair = pairs[i];
				var colonPos = pair.indexOf(":");
				if (colonPos == -1) continue;
				
				var key = pair.substring(0, colonPos).split('"').join('').split(' ').join('');
				var val = pair.substring(colonPos + 1).split('"').join('').split(' ').join('');
				
				// Try to numerate
				if (val == "true") {
					obj[key] = true;
				} else if (val == "false") {
					obj[key] = false;
				} else if (val == "null") {
					obj[key] = null;
				} else if (!isNaN(Number(val))) {
					obj[key] = Number(val);
				} else {
					obj[key] = val;
				}
			}
			
			items.push(obj);
			pos = end + 1;
		}
		
		callback(items);
		
	};
	
	lv.load(url);
}