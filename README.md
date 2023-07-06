
# LiveWallpaperConfigs

This class allows you to easily create settings for Opera GX live wallpapers.

![image](https://github.com/FoxyOfJungle/LiveWallpaperConfigs/assets/52144406/31fdfc48-acb3-419c-91bd-b53313de632f)


## Installation

Download the .yymps file from the "Releases" tab in the right.
Inside GameMaker:  

1 - Go to menu "Tools > Import Local Package";  
2 - Add all;  
3 - Import.  

## Example

```gml
// my variables
variable_color = c_white;

// Wallpaper Configuration
lw_config = new WallpaperConfiguration([
	new WP_Section("Performance", "perf", [
		new WP_OptionSelect("Speed:", "lw_speed", ["Low", "Normal", "Blazing"], "Normal", "The wallpaper speed in frames per second"),
	]),
	new WP_Section("Appearance", "appearance", [
		new WP_OptionColor("Color", "color", c_white),
	]),
],

function(callback) {
  // update variable
  variable_color = callback.appearance.color;
});

// send to Opera GX browser
lw_config.Set();
```
