extends CanvasLayer

var screensize

func _ready():
	screensize = get_viewport().get_rect().size
	$Info/Label.hide()
	$Info/ColorRect.hide()
	$AnimatedSprite.position.x = screensize.x / 2
	$AnimatedSprite.position.y = screensize.y / 2
	$AnimatedSprite.play()

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
	$Info/Label.show()
	$Info/ColorRect.show()
