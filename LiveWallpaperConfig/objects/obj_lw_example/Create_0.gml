
// Tests
variable_test = 10;
variable_color = c_orange;



// Wallpaper Configuration
lw_config = new WallpaperConfiguration([
	new WP_Section("Performance", "perf", [
		new WP_OptionSelect("Speed:", "lw_speed", ["Low", "Normal", "Blazing"], "Normal", "The wallpaper speed in frames per second"),
	]),
	new WP_Section("Appearance", "appearance", [
		new WP_OptionSelect("Scale Mode:", "scale", ["Scale", "Stretch"], "Scale", "Determines the type of wallpaper scale"),
		new WP_OptionRange("Stuff", "stuff", 100, 50, 5000, 10),
		new WP_OptionColor("Color", "color", c_white),
	]),
],

function(callback) {
	//if (DEV_MODE) exit;
	
	// Performance
	// speed
	switch(callback.perf.lw_speed) {
		case "Low":
			game_set_speed(24, gamespeed_fps);
			break;
		case "Normal":
			game_set_speed(30, gamespeed_fps);
			break;
		case "Blazing":
			game_set_speed(60, gamespeed_fps);
			break;
	}
	
	// Appearance
	// scale
	switch(callback.appearance.scale) {
		case "Scale":
			// 
			break;
		case "Stretch":
			//
			break;
	}
	
	// stuff
	variable_test = callback.appearance.stuff;
	
	// color
	variable_color = callback.appearance.color;
	
});

lw_config.Set();


