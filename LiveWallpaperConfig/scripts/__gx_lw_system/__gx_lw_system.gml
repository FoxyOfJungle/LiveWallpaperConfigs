
/*---------------------------------------------------
	LiveWallpaperConfig, (C) 2023, FoxyOfJungle
	
	https://foxyofjungle.itch.io
	https://twitter.com/foxyofjungle
---------------------------------------------------*/
show_debug_message($"LiveWallpaperConfig | Copyright (C) 2023 FoxyOfJungle");


/// @desc Function Description
/// @param {Array} sections_array Description
/// @param {Function} callback The callback to be executed when returning data from the Opera GX browser
function WallpaperConfiguration(sections_array, callback=undefined) constructor {
	data_array = []; // array with sections
	callback_func = callback;
	time_source = undefined;
	
	if (is_undefined(sections_array)) {
		show_debug_message("Wallpaper configuration is empty!");
		exit;
	}
	
	// add sections to data
	var i = 0, isize = array_length(sections_array);
	repeat(isize) {
		array_push(data_array, sections_array[i]);
		++i;
	}
	
	#region Public Methods
	
	/// @func AddSection(section_struct)
	/// @param {Struct} section_struct The section item struct.
	static AddSection = function(section_struct) {
		array_push(data_array, section_struct);
		return self;
	}
	
	/// @desc Send configs to the browser.
	/// @func Set()
	static Set = function() {
		if (array_length(data_array) > 0) {
			wallpaper_set_config(data_array);
		} else {
			show_debug_message("Wallpaper configuration is empty!");
		}
	}
	
	/// @desc Execute callbacks from items based on the values returned by the browser.
	/// @func Update()
	static Update = function() {
		if (time_source != undefined) time_source_destroy(time_source);
		time_source = time_source_create(time_source_game, 1, time_source_units_frames, callback_func, [wallpaper_config]);
		time_source_start(time_source);
	}
	
	/// @desc Frees the memory of resources created by the class.
	/// @func Clean()
	static Clean = function() {
		if (time_source != undefined) time_source_destroy(time_source);
		
	}
	
	#endregion
}

// -------------------------

// super class
/// @ignore
function __wp_item() {
	type = "";
	name = "";
	label = "";
	callback = undefined;
}

// Sections
// These are sections/separators, which will categorize the items.
// "variable_name" is what will be returned by the struct, when receiving a "callback".

function WP_Section(label_name, variable_name, items_array) : __wp_item() constructor {
	type = "section";
	name = variable_name;
	label = label_name;
	children = [];
	
	var i = 0, isize = array_length(items_array);
	repeat(isize) {
		array_push(children, items_array[i]);
		++i;
	}
	
	/// @func AddOption(item_struct)
	static AddOption = function(item_struct) {
		array_push(children, item_struct);
	}
}


// Options
// These are the items, where it will be possible to control and return callbacks.
// "variable_name" is what will be returned by the struct, when receiving a "callback".

function WP_OptionRange(label_name, variable_name, value, min_val, max_val, stepp) : __wp_item() constructor {
	type = "range";
	name = variable_name;
	label = label_name;
	
	self.value = value;
	self.min = min_val;
	self.max = max_val;
	self.step = stepp;
}

function WP_OptionBoolean(label_name, variable_name, value) : __wp_item() constructor {
	type = "boolean";
	name = variable_name;
	label = label_name;
	
	self.value = value;
}

function WP_OptionSelect(label_name, variable_name, options_array, value, description) : __wp_item() constructor {
	type = "select";
	name = variable_name;
	label = label_name;
	
	self.value = value;
	self.options = options_array;
	self.description = description;
}

function WP_OptionString(label_name, variable_name, value) : __wp_item() constructor {
	type = "string";
	name = variable_name;
	label = label_name;
	
	self.value = value;
}

function WP_OptionText(label_name, variable_name, value) : __wp_item() constructor {
	type = "string_multiline";
	name = variable_name;
	label = label_name;
	
	self.value = value;
}

function WP_OptionColor(label_name, variable_name, value) : __wp_item() constructor {
	type = "colour";
	name = variable_name;
	label = label_name;
	
	self.value = value;
}

function WP_OptionFile(label_name, variable_name, value) : __wp_item() constructor {
	type = "file";
	name = variable_name;
	label = label_name;
	
	self.value = value;
}

function WP_OptionFolder(label_name, variable_name, value) : __wp_item() constructor {
	type = "folder";
	name = variable_name;
	label = label_name;
	
	self.value = value;
}
