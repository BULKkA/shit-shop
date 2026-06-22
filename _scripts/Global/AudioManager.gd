extends Node

const SFX_CHANNELS := 16 

var music_player: AudioStreamPlayer
var sfx_players: Array[AudioStreamPlayer]

func _ready() -> void:
	
	Signals.Play_Sound.connect(Play_Sound)
	
	music_player = AudioStreamPlayer.new()
	music_player.name = "MusicPlayer"
	music_player.bus = "Music"
	add_child(music_player)
	for i in SFX_CHANNELS:
		var player := AudioStreamPlayer.new()
		player.name = "SFX" + str(i)
		player.bus = "SFX"
		add_child(player)
		sfx_players.append(player)

func play_music(stream: AudioStream):
	if music_player.stream == stream and music_player.playing:
		return
	music_player.stop()
	music_player.stream = stream
	music_player.play()

func stop_music():
	music_player.stop()

func play_sfx(stream: AudioStream):
	for player in sfx_players:
		if not player.playing:
			player.stream = stream
			player.play()
			return
	sfx_players[0].stop()
	sfx_players[0].stream = stream
	sfx_players[0].play()

func Play_Sound(Type, Name):
	var sound = Sounds.soundByName("Theme_" + Name)
	if Type == Sounds.Type.Music:
		play_music(sound)
	else:
		play_sfx(sound)
