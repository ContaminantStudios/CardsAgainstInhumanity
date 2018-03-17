extends CanvasLayer

var screensize

func _ready():
	randomize()
	screensize = get_viewport().size
	$Info.hide_all()
	$AnimatedSprite.position.x = screensize.x / 2
	$AnimatedSprite.position.y = screensize.y / 2
	$AnimatedSprite.play()
	# $AudioStreamPlayer.play() uncomment for audio

func _process(delta):
	screensize = get_viewport().size
	$AnimatedSprite.position.x = screensize.x / 2
	$AnimatedSprite.position.y = screensize.y / 2
	if Input.is_key_pressed(KEY_ESCAPE):
		exit_game()

func exit_game():
	get_tree().quit()

func on_info_pressed():
	$Info.show_all()

func start_game():
	get_tree().change_scene("res://scenes/Game.tscn")
