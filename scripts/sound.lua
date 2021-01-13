local sound = {
	menu = audio.loadSound( 'sounds/menu_music.mp3' ),
	openMouth = audio.loadSound( 'sounds/open_mouth.mp3' ),
	chew = audio.loadSound( 'sounds/monster_chewing.mp3' ),
	sad = audio.loadSound( 'sounds/sad.mp3' ),
	game = audio.loadSound( 'sounds/game_music.mp3' )
}

function sound:disposeAll()
	for s,v in pairs(sound) do
		audio.dispose( sound[i] )
		sound[s] = nil
	end
end

return sound
