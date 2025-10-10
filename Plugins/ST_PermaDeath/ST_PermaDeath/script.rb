#===========================================================
# Stahltier's Pokemon Permadeath
# for PE v21.1
#
# Kill Pokemon if they faint, as long as a Switch is ON.
# Will display a nicer message if you have my ST_Utiliy plugin installed as well.
#
#===========================================================

ST_Utils_imported = PluginManager.installed?("Stahltier's Utility Scripts")

module ST

  # CONFIG START
  # Change the ID of the switch to whichever Switch you want to turn ON or OFF in order to enable the permadeath functionality.
  # You can then simply 
  # By default, this plugin uses the Switch 80.
  PERMADEATH_SWITCH = 80
  # If your game allows Pokemon to faint from poison outside of battle, they will now die instantly instead of at the end of the next battle.
  # You can manually override this behavior here if you want by setting the value to true or false instead of "Settings::POISON_FAINT_IN_FIELD"
  # You can also set this value to false if you are experiencing compatibility issues with other scripts/plugins, because I am overriding the
  # EventHandler for the default behavior of poisoned Pokemon outside of battle if the value is true (or resolves to true).
  DIE_IN_FIELD = Settings::POISON_FAINT_IN_FIELD
  # If the value below is true, the player will pass out when all of their (able) Pokemon are dead. Set it to false to let the player continue
  # running around, preventing a possible softlock.
  BLACKOUT_IF_ALL_DEAD = false
  
  # CONFIG END
  # Do not make any edits past this line unless you know what you are doing.
end

class Game_System
  attr_accessor :dead_pkmn
  
  alias pkmn_permadeath_initialize initialize
  def initialize
	  echoln "[ST_PermaDeath] INFO: Stahltier's Utility script installed, will display prettier death messages." if ST_Utils_imported
	  pkmn_permadeath_initialize
	  @dead_pkmn = @dead_pkmn || []
  end
end

class Game_Temp
  attr_accessor :all_dead_notified
  
  alias pkmn_permadeath_initialize initialize
  def initialize
	  pkmn_permadeath_initialize
	  @all_dead_notified = @all_dead_notified || false
  end
  
  def all_dead_notified?
	return @all_dead_notified
  end
end

EventHandlers.add(:on_end_battle, :remove_fainted_battlers, proc do |_outcome, _can_lose|
  next if !$game_switches[ST::PERMADEATH_SWITCH]
  tmp_dead = []
  tmp_dead = $player.party.find_all { |p| p && !p.egg? && p.fainted? }
  # announce deaths
  if !tmp_dead.empty?
	dead_txt = ""
	if tmp_dead.count == 1
	  col = "<c2=06644bd2>"
	  col = "<c2=65467b14>" if tmp_dead[0].male?
	  col = "<c2=043c3aff>" if tmp_dead[0].female?
      dead_txt = "Your Lv.#{tmp_dead[0].level.to_s} #{col}#{tmp_dead[0].name}</c2> has died."
	else
	  if ST_Utils_imported
	    dead_txt = "#{tmp_dead.count.in_words.capitalize} of your Pokémon have died:"
	  else
	    dead_txt = "Some of your Pokémon have died:"
	  end
	  tmp_dead.each {|pkmn| 
		col = "<c2=06644bd2>"
		col = "<c2=65467b14>" if pkmn.male?
		col = "<c2=043c3aff>" if pkmn.female?
		dead_txt += "\n" 
		dead_txt += "Lv.#{pkmn.level.to_s} "
		dead_txt += "#{col}#{pkmn.name}</c2>"
	  }
	end
	pbMessage(_INTL(dead_txt))
    # add dead pokemon to the already tracked other dead ones
    $game_system.dead_pkmn = [] if $game_system.dead_pkmn.nil?
	$game_system.dead_pkmn.concat(tmp_dead)
  end
  $player.party.keep_if { |pkmn| pkmn.hp.positive? }
end)

class Battle
  def pbKillAll
    # kill the whole party (except eggs)
	return if !$game_switches[ST::PERMADEATH_SWITCH]
	$player.party.keep_if { |pkmn| pkmn.egg? }
  end

  alias pkmn_permadeath_pbLoseMoney pbLoseMoney
  def pbLoseMoney
	# for some reason we have to kill the Pokemon AGAIN here...
	pbKillAll
	return if wildBattle? || !$game_switches[ST::PERMADEATH_SWITCH]
	pkmn_permadeath_pbLoseMoney
  end
end

if ST::DIE_IN_FIELD
  # Reminder: If you are experiencing compatibility issues, set DIE_IN_FIELD to false in the CONFIG section of this script.
  EventHandlers.remove(:on_player_step_taken_can_transfer, :poison_party)
  EventHandlers.add(:on_player_step_taken_can_transfer, :poison_party,
  proc { |handled|
    # handled is an array: [nil]. If [true], a transfer has happened because of
    # this event, so don't do anything that might cause another one
    next if handled[0]
    next if !Settings::POISON_IN_FIELD || $PokemonGlobal.stepcount % 4 != 0
    flashed = false
    $player.able_party.each do |pkmn|
      next if pkmn.status != :POISON || pkmn.hasAbility?(:IMMUNITY)
      if !flashed
        pbSEPlay("Poison step")
        pbFlash(Color.new(255, 0, 0, 128), 8)
        flashed = true
      end
      pkmn.hp -= 1 if pkmn.hp > 1 || Settings::POISON_FAINT_IN_FIELD
      if pkmn.hp == 1 && !Settings::POISON_FAINT_IN_FIELD
        pkmn.status = :NONE
		col = "<c2=06644bd2>"
	    col = "<c2=65467b14>" if pkmn.male?
	    col = "<c2=043c3aff>" if pkmn.female?
        pbMessage(_INTL("{2}{1}</c2> survived the poisoning.\\nThe poison faded away!", pkmn.name, col))
        next
      elsif pkmn.hp == 0
        pkmn.changeHappiness("faint")
        pkmn.status = :NONE
		col = "<c2=06644bd2>"
	    col = "<c2=65467b14>" if pkmn.male?
	    col = "<c2=043c3aff>" if pkmn.female?
		if $game_switches[ST::PERMADEATH_SWITCH]
		  pbMessage(_INTL("{2}{1}</c2> has died from poison...", pkmn.name, col))
		  # add dead pokemon to the already tracked other dead ones
		  $game_system.dead_pkmn = [] if $game_system.dead_pkmn.nil?
		  $game_system.dead_pkmn.push(pkmn)
		else
		  pbMessage(_INTL("{2}{1}</c2> fainted from poison...", pkmn.name, col))
		end
      end
    end
	if $game_switches[ST::PERMADEATH_SWITCH]
	  $player.party.keep_if { |pkmn| pkmn.hp.positive? } 
	end
	if $player.able_pokemon_count == 0
	  handled[0] = true
	  pbCheckAllFainted
    end
  })

	alias pkmn_permadeath_pbStartOver pbStartOver
	def pbStartOver(gameover = false)
	  if !ST::BLACKOUT_IF_ALL_DEAD || !$game_switches[ST::PERMADEATH_SWITCH]
		if pbInBugContest?
		  pbBugContestState.pbEnd
		  pbBugContestState.clear
		end
		$stats.blacked_out_count += 1
		if $PokemonGlobal.pokecenterMapId && $PokemonGlobal.pokecenterMapId >= 0
		  pbMessage("\\w[]\\wm\\c[8]\\l[3]" +
			_INTL("Avoiding further danger, you quickly retreat back to safety."))
		  pbCancelVehicles
		  Followers.clear
		  $game_temp.player_new_map_id    = $PokemonGlobal.pokecenterMapId
		  $game_temp.player_new_x         = $PokemonGlobal.pokecenterX
		  $game_temp.player_new_y         = $PokemonGlobal.pokecenterY
		  $game_temp.player_new_direction = $PokemonGlobal.pokecenterDirection
		  pbDismountBike
		  $scene.transfer_player if $scene.is_a?(Scene_Map)
		  $game_map.refresh
		else
		  homedata = GameData::PlayerMetadata.get($player.character_ID)&.home
		  homedata = GameData::Metadata.get.home if !homedata
		  if homedata && !pbRgssExists?(sprintf("Data/Map%03d.rxdata", homedata[0]))
			if $DEBUG
			  pbMessage(_ISPRINTF("Can't find the map 'Map{1:03d}' in the Data folder. The game will resume at the player's position.", homedata[0]))
			end
			return
		  end
		  pbMessage("\\w[]\\wm\\c[8]\\l[3]" +
			_INTL("Avoiding further danger, you quickly retreat back to to safety."))
		  if homedata
			pbCancelVehicles
			Followers.clear
			$game_temp.player_new_map_id    = homedata[0]
			$game_temp.player_new_x         = homedata[1]
			$game_temp.player_new_y         = homedata[2]
			$game_temp.player_new_direction = homedata[3]
			pbDismountBike
			$scene.transfer_player if $scene.is_a?(Scene_Map)
			$game_map.refresh
		  end
		end
		pbEraseEscapePoint
	  else
		pkmn_permadeath_pbStartOver(gameover)
	  end
	end

	alias pkmn_permadeath_pbCheckAllFainted pbCheckAllFainted
	def pbCheckAllFainted
	  if ST::BLACKOUT_IF_ALL_DEAD
	    if !$game_switches[ST::PERMADEATH_SWITCH]
	      $game_temp.all_dead_notified = false
	    end
	    if !$game_temp.all_dead_notified?
		  $game_temp.all_dead_notified = true
		  pkmn_permadeath_pbCheckAllFainted
		else
		  $game_temp.all_dead_notified = $player.able_pokemon_count == 0
		end
	  end
	end
end