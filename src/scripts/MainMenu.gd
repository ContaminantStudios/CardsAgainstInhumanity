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
	make_card()

func _process(delta):
	screensize = get_viewport().size
	$AnimatedSprite.position.x = screensize.x / 2
	$AnimatedSprite.position.y = screensize.y / 2
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


func start_game():
	pass # replace with function body

func make_card():
	var card_scene = preload("res://scenes/Card.tscn")
	var card_node = card_scene.instance()
	card_node.init(, Vector2(0, 0))
	add_child(card_node)
	card_node
