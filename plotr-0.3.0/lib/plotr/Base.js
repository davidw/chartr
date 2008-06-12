/*
	Plotr.Base
	==========	
	Plotr.Base is part of the Plotr Charting Framework. Plotr.Base
	contains functions that are needed by the rest if the Plotr
	files.
	
	For license/info/documentation: http://www.solutoire.com/plotr/
	
	Credits
	-------
	Plotr is partially based on PlotKit (BSD license) by
	Alastair Tse <http://www.liquidx.net/plotkit>.
	
	Copyright
	---------
 	Copyright 2007 (c) Bas Wenneker <sabmann[a]gmail[d]com>
 	For use under the BSD license. <http://www.solutoire.com/plotr>
*/

if(typeof(Prototype) == 'undefined' || Prototype.Version < '1.5.1'){
	throw 'Plotr depends on the Prototype framework (version 1.5.1).';
}

if(typeof(Plotr) == 'undefined'){
	Plotr = {
		author:  'Bas Wenneker',
		name: 	 'Plotr',
		version: '{version}'
	};
}

if(typeof(Plotr.Base) == 'undefined'){
	Plotr.Base = {};
}

/*
	Function: items
		Collects all the nonfunction values of the passed object.
	
	Parameters:
		obj - Object with key:value pairs.
	
	Returns:
		An array of all nonfunction values of obj.
		
	Example:
		(start code)
		var value_arr = Plotr.Base.items({
			foo: 'bar',
			baz: 99,
			fooFunc: function(){ }
		}); //=> ['bar', 99]		
		(end)
*/
Plotr.Base.items = function(/*Object*/obj){
	
	return Object.values(obj).reject(function(item){
		return (typeof(item) == 'function');
	});
};

/*
	Function: Plotr.Base.merge
		Recursively merge the passed objects. The 1nd arguments attributes are overwritten by the attributes of the 2nd argument.
		
	Parameters:
		ext - Some object to extend.
		obj - Object that overrides ext.
	
	Example:
		(start code)
		var a = {
			foo:{
				bar: 'foo.bar',
				baz: 2
			},
			boo: null
		};
		
		var b = {
			foo: {
				bar: 99,
				barbaz: 'hi'
			}
		};		
		
		var merged = Plotr.Base.merge(a, b);
		
		// merged now holds: 
		// {
		//		foo: {bar: 99, baz: 2, barbaz: 'hi'},
		//		boo: null
		// }		
		(end)
*/
Plotr.Base.merge = function(/*Object*/ext, /*Object*/obj){
	
	var result = ext || {};
    for(var i in obj){		
		result[i] = (typeof(obj[i]) == 'object' && !(obj[i].constructor == Array || obj[i].constructor == RegExp)) ? Plotr.Base.merge(ext[i], obj[i]) : result[i] = obj[i];        
    }
    return result;
};

/*
	Function: isNil
		Check if the passed object is null or undefined.
	
	Parameters:
		obj - Object to check.
	
	Returns:
		True if obj is null or undefined, false otherwise.
*/
Plotr.Base.isNil = function(/*Object*/obj){
	
	return (obj === null || typeof(obj) == 'undefined');
};

/*
	Function: excanvasSupported
		Check if canvas simulation by ExCanvas is supported by the browser.
		
	Returns:
		True if userAgent is IE, false otherwise.
*/
Plotr.Base.excanvasSupported = function(){
	
	return (/MSIE/.test(navigator.userAgent) && !window.opera);
};

/*
	Function: isSupported
		Check if canvas is supported by the browser.
		
	Parameters:
		canvasId - (optional) Id of the canvas element.
		
	Returns:
		True if canvas is supported, false otherwise.
*/
Plotr.Base.isSupported = function(/*String*/canvasId){
    
    try{
		((Plotr.Base.isNil(canvasId)) ? document.createElement('canvas') : $(canvasId)).getContext('2d');
		
    }catch(e){
        
		var ie = navigator.appVersion.match(/MSIE (\d\.\d)/);
		return ((!ie) || (ie[1] < 6) || (navigator.userAgent.toLowerCase().indexOf('opera') != -1));
    }
	return true;
};

/*
	Function: uniqueIndices
		Checks arr for the element with the largest length and returns an array with elements 0 .. length.
	
	Parameters:
		arr - Array of arrays.
		
	Returns:
		An array with a range of integers.
		
	Example:
		(start code)
		var someArray = [
			['hello', 'world'],
			['plotr', 'rulez', 'yeah'],
			['l33t']
		];
		var range = Plotr.Base.uniqueIndices(someArray); //=> [0, 1, 2]
		(end)
*/
Plotr.Base.uniqueIndices = function(/*Array*/arr){
	
	return new ObjectRange(0,arr.max(function(item){		
		return item.length;
	})).toArray();	
};

/*
	Function: sum
		Counts all integers in the array.
	
	Parameters:
		arr - Array of Integers.
		
	Returns:
		Returns the sum of all integers in the passed array.
*/
Plotr.Base.sum = function(/*Integer[]*/ arr){
	
	return arr.flatten().inject(0, function(sum, n) { 
		return sum + n; 
	});
};

/*
	Function: generateColorscheme
		This function generates a colorScheme based on the passed hex string. It returns an Hash with the name of the dataset key as key, and a color as corresponding value.
	
	Parameters;
		hex - String with hexadecimal color code like '#ffffff'.
		keys - Keys of the corresponding Dataset Hash.
		
	Returns:
		An Hash with color codes.
		
	Example:
		(start code)
		var keys = [
			'firstSet',
			'secondSet',
			'thirdSet'
		];
		var scheme = Plotr.Base.generateColorscheme('#000000', keys);
		//=> {firstSet: '#<hexcode>', secondSet: '#<hexcode>', thirdSet: '#<hexcode>'}
		(end)
*/
Plotr.Base.generateColorscheme = function(/*String*/hex, /*String[]*/keys){
	
	if(keys.length === 0){
		return new Hash();
	}
	
	var color = new Plotr.Color(hex);
	var result = new Hash();
	
	keys.each(function(index){
		result[index] = color.lighten(25).toHexString();
	});
	
	return result;
};

/*
	Function: defaultScheme
		Function that returns the default colorscheme for Plotr.
	
	Parameters:
		keys - Keys of the corresponding Dataset Hash.
		
	Returns:
		An Hash with color codes.
*/
Plotr.Base.defaultScheme = function(/*String[]*/keys){
	
	return Plotr.Base.generateColorscheme('#3c581a', keys);
};


/*
	Function: getColorscheme
		Function returns a colorscheme, but the input can be {red, green, blue, grey, black}.
		
	Parameters:
		hex - String with hexadecimal color code like '#ffffff'.
		keys - Keys of the corresponding Dataset Hash.
		
	Returns:
		An Hash with color codes.
*/
Plotr.Base.getColorscheme = function(/*String*/color, /*String[]*/keys){
	
	return Plotr.Base.generateColorscheme(Plotr.Base.colorSchemes[color] || color, keys);
};

/*
	 Object: colorSchemes
	 	Object with key:value pairs that assigns a color name to a hex color code. These are the predefined color schemes.
*/
Plotr.Base.colorSchemes = {
	red: '#6d1d1d',
	green: '#3c581a',
	blue: '#224565',
	grey: '#444444',
	black: '#000000',
	darkcyan: '#305755'
};