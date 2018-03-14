extends CanvasLayer

var screensize

func _ready():
	randomize()
	screensize = get_viewport().size
	$Info/Label.hide()
	$Info/ColorRect.hide()
	$AnimatedSprite.position.x = screensize.x / 2
	$AnimatedSprite.position.y = screensize.y / 2
	$AnimatedSprite.play()
	$AudioStreamPlayer.play()

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		exit_game()

func exit_game():
	get_tree().quit()

func on_difficulty_pressed():
	if $DifficultyButton.text == "Difficulty (Easy)":
		$DifficultyButton.text = "Difficulty (Med)"
	elif $DifficultyButton.text == "Difficulty (Med)":
		$DifficultyButton.text = "Difficulty (Hard)"
	else:
		$DifficultyButton.text = "Difficulty (Easy)"

func on_info_pressed():
	$Info.show_all()
