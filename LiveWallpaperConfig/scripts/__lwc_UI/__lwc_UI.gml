/// Feather ignore all
/*==========================================================================
	Live Wallpaper Config, (C) 2024 FoxyOfJungle
	
	https://foxyofjungle.itch.io
	https://twitter.com/foxyofjungle
==========================================================================*/

// Init
show_debug_message($"LiveWallpaperConfig | Copyright (C) 2024 FoxyOfJungle");

/// @desc Creates a class responsible for creating the Live Wallpaper configuration UI.
/// @param {Array} sections_array The list of sections.
/// @param {Function} callback The callback to be executed when returning data from the Opera GX browser
function WallpaperConfiguration(_sectionsArray, _callback=undefined) constructor {
	__dataArray = []; // array with sections
	__callbackFunc = _callback;
	__timeSource = undefined;
	
	if (is_undefined(_sectionsArray)) {
		show_debug_message("Wallpaper configuration is empty!");
		exit;
	}
	
	// add sections to data
	var i = 0, isize = array_length(_sectionsArray);
	repeat(isize) {
		array_push(__dataArray, _sectionsArray[i]);
		++i;
	}
	
	#region Public Methods
	
	/// @func AddSection(section_struct)
	/// @param {Struct} section_struct The section item struct.
	static AddSection = function(_sectionStruct) {
		array_push(__dataArray, _sectionStruct);
		return self;
	}
	
	/// @desc Send configs to the browser.
	/// @func Set()
	static Set = function() {
		if (array_length(__dataArray) > 0) {
			wallpaper_set_config(__dataArray);
		} else {
			show_debug_message("Wallpaper configuration is empty!");
		}
	}
	
	/// @desc Execute callbacks from items based on the values returned by the browser.
	/// @func Update()
	static Update = function() {
		if (__timeSource != undefined) time_source_destroy(__timeSource);
		__timeSource = time_source_create(time_source_game, 1, time_source_units_frames, __callbackFunc, [wallpaper_config]);
		time_source_start(__timeSource);
	}
	
	/// @desc Frees the memory of resources created by the class.
	/// @func Clean()
	static Clean = function() {
		if (__timeSource != undefined) time_source_destroy(__timeSource);
		
	}
	
	#endregion
}

// -------------------------------------------------------------------------------
// Super Class
/// @ignore
function __WP_Item() constructor {
	type = "";
	name = "";
	label = "";
	callback = undefined;
}

// -------------------------------------------------------------------------------
// Sections
// These are sections/separators, which will categorize the items.
// "_variableName" is what will be returned by the struct, when receiving a "callback".

function WP_Section(_labelName, _variableName, _itemsArray) : __WP_Item() constructor {
	type = "section";
	name = _variableName;
	label = _labelName;
	children = [];
	
	var i = 0, isize = array_length(_itemsArray);
	repeat(isize) {
		array_push(children, _itemsArray[i]);
		++i;
	}
	
	/// @func AddOption(item_struct)
	static AddOption = function(item_struct) {
		array_push(children, item_struct);
	}
}

// Options
// These are the items, where it will be possible to control and return callbacks.
// "_variableName" is what will be returned by the struct, when receiving a "callback".

/// @desc Slider option.
function WP_OptionRange(_labelName, _variableName, _value, _minVal, _maxVal, _step, _description="") : __WP_Item() constructor {
	type = "range";
	name = _variableName;
	label = _labelName;
	
	self.value = _value;
	self.min = _minVal;
	self.max = _maxVal;
	self.step = _step;
	self.description = _description;
}

/// @desc Boolean/Toggle option.
function WP_OptionBoolean(_labelName, _variableName, _value, _description="") : __WP_Item() constructor {
	type = "boolean";
	name = _variableName;
	label = _labelName;
	
	self.value = _value;
	self.description = _description;
}

/// @desc Select Dropdown Menu option.
function WP_OptionSelect(_labelName, _variableName, _optionsArray, _value, _description="") : __WP_Item() constructor {
	type = "select";
	name = _variableName;
	label = _labelName;
	
	self.value = _value;
	self.options = _optionsArray;
	self.description = _description;
}

/// @desc Single-line text field.
function WP_OptionString(_labelName, _variableName, _value, _description="") : __WP_Item() constructor {
	type = "string";
	name = _variableName;
	label = _labelName;
	
	self.value = value;
	self.description = _description;
}

/// @desc Multiple-line text field.
function WP_OptionText(_labelName, _variableName, _value, _description="") : __WP_Item() constructor {
	type = "string_multiline";
	name = _variableName;
	label = _labelName;
	
	self.value = _value;
	self.description = _description;
}

/// @desc Color picker.
function WP_OptionColor(_labelName, _variableName, _value, _description="") : __WP_Item() constructor {
	type = "colour";
	name = _variableName;
	label = _labelName;
	
	self.value = _value;
	self.description = _description;
}

/// @desc File button (returns the file's path).
function WP_OptionFile(_labelName, _variableName, _value, _description="") : __WP_Item() constructor {
	type = "file";
	name = _variableName;
	label = _labelName;
	
	self.value = value;
	self.description = _description;
}

/// @desc Folder button (returns the folder path).
function WP_OptionFolder(_labelName, _variableName, _value, _description="") : __WP_Item() constructor {
	type = "folder";
	name = _variableName;
	label = _labelName;
	
	self.value = _value;
	self.description = _description;
}
