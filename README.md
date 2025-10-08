# Pokemon Essentials Plugins
Here you can find my plugins and resources for Pokemon Essentials.
I use PE v21.1, so I can only guarantee that they are compatible with that version of the kit. They most likely won't be compatible with higher or lower versions.

The plugins and resources are provided as is and you download and use them at your own risk. I'm not responsible for your project breaking or incompatibilities with other plugins/scripts. Even though I try to test my code thoroughly and use it in my own project(s), it's always possible that there are bugs or fringe cases I didn't encounter while testing. **Always make a backup of your project before importing new scripts/plugins/resources!**

## Plugins
For all the plugins uploaded here, the install instructions are the same: Download the plugin as a zip, then unpack it with your favorite archive processing software of choice. You will find at least one folder in there that's called Plugins and contains a folder with the name of the plugin, which in turns contains a meta.txt as well as one or more Ruby files (filename ending in .rb). Make sure to copy the entire folder called Plugins into your project's root folder (the one that should already contain a folder called Plugins).

If there are additional folders in the zip you downloaded (for example Graphics), make sure to copy those into your project's root folder as well.
Some of my plugins contain configurable settings. They will either be at the top of the script Ruby file (identified by comments inside the file), or povided as a seperate 0_settings.rb file that is contained in the same folder as the 1_script.rb! Follow the comments in the code to customize these settings but don't change anything else except these values unless you know what you're doing and want to modify the actual code of the plugin.

Any plugin that has a more elaborate install process will contain a Readme.txt that explains how to set it up properly.
### Ride & Surf Plugin
This plugin mainly lets you display the overworld sprite of the Pokémon that used SURF instead of the generic default surfing sprite.
In order for this to work correctly, you need to make sure the sprites actually exist in your project - check out the 0_settings.rb to see what files the plugin expects to find and where.
There is an optional "HM Ride" feature in this plugin, which you can ignore if you don't want to use such a mechanic. Change the values in the 0_settings.rb in order to enable this feature (it's disabled by default).
