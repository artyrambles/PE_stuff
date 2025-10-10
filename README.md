# Pokemon Essentials Stuff
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

## Resources
These are some graphics and data files that I made and am okay with sharing for others to use in their fangames.
Please give credit to me when using them. They are only meant for use in non-commercial Pokemon fangames, but can be used outside of Pokemon Essentials if you make your own adjustments to make them compatible.
### Retro Charmander
This is an edit to the sprite of the vanilla Charmander that I made to look more like its old generation 1 artwork and sprites.
I packaged it to be used with Pokemon Essentials v21.1, it comes with all the needed graphics and PBS files to make it either a default replacement for the vanilla Charmander or an alternate form. The Graphics and PBS folder just have to be dropped inside your game's root folder and you're ready to go, if you're using the Generation 9 Resource Pack and want to add the Retro Charmander as a new form.
Check inside the downloaded archive for optional files for pre-arranged and correctly named folders/files if you aren't using the Generation 9 Resource Pack or if you want this Charmander to replace the default one, or if you want the vanilla shiny colors instead of the edited ones.

<img width="160" height="160" alt="CHARMANDER_1" src="https://github.com/user-attachments/assets/c2c392ce-ce9d-4dee-875b-856d04f2daad" /> <img width="288" height="288" alt="CHARMANDER_1" src="https://github.com/user-attachments/assets/4ae62584-7e8f-431a-a7eb-e8ae5ac2d3dc" /> <img width="160" height="160" alt="CHARMANDER" src="https://github.com/user-attachments/assets/a3be30fe-9386-4bbc-adfe-d92fff4cab16" />

Make sure to recompile the PBS files in the playtest if you are using the forms.
