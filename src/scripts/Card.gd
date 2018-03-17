extends Area2D

const CARDS = ['CARD_00', 'CARD_01', 'CARD_02']
const R_CHANCES = [0.8, 0.7, 0.4]
const N_CHANCES = [0.4, 0.3, 0.1]
const R_VALS = [50, 40, 20]
const N_VALS = [20, 20, 5]
const S_VALS = [8, 5, 2]
const POINT_TYPES = ['P', 'E', 'E']
var card
var r_chance
var n_chance
var r_val
var n_val
var s_val
var point_type
var start_embiggening
var embiggening
var start_minimizing
var minimizing
var t

func init(card_id, pos):
	card = CARDS[card_id]
	r_chance = R_CHANCES[card_id]
	n_chance = N_CHANCES[card_id]
	r_val = R_VALS[card_id]
	n_val = N_VALS[card_id]
	s_val = S_VALS[card_id]
	point_type = POINT_TYPES[card_id]
	$AnimatedSprite.animation = card
	position = pos
	embiggening = false
	t = 0.0

func _process(delta):
	if start_embiggening:
		embiggening = true
		minimizing = false
		t = 0
		start_embiggening = false
	
	if start_minimizing:
		minimizing = true
		embiggening = false
		t = 0
		start_minimizing = false

	if embiggening:
		t += delta
		scale.x = clamp(-0.1 * cos((PI / 0.5) * t) + 0.4, 0.3, 0.5)
		scale.y = clamp(-0.1 * cos((PI / 0.5) * t) + 0.4, 0.3, 0.5)
		embiggening = scale.x < 0.498
	elif minimizing:
		t += delta
		scale.x = clamp(0.1 * cos((PI / 0.5) * t) + 0.4, 0.3, 0.5)
		scale.y = clamp(0.1 * cos((PI / 0.5) * t) + 0.4, 0.3, 0.5)
		minimizing = scale.x > 0.302

func play(col):
	var val_sign
	match col:
		'R':
			val_sign = 1 if randf() > r_chance else -1
			return r_val * val_sign
		'N':
			val_sign = 1 if randf() > n_chance else -1
			return n_val * val_sign
		_:
			return s_val

func get_point_type():
	return point_type

func move(pos):
	position = pos

func card_mouse_entered():
	start_embiggening = true


func card_mouse_exited():
	start_minimizing = true


func card_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		print("Card Pressed")
