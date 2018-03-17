extends Area2D

signal in_column
signal out_of_column
signal turn_done

const CARDS = ['CARD_00', 'CARD_01', 'CARD_02', 'CARD_03', 'CARD_04', 'CARD_05', 'CARD_06', 'CARD_07', 'CARD_08', 'CARD_09', 'CARD_10', 
	'CARD_11', 'CARD_12', 'CARD_14', 'CARD_15', 'CARD_16', 'CARD_17', 'CARD_18', 'CARD_19', 'CARD_20', 'CARD_21', 'CARD_22', 'CARD_23', 'CARD_24']
const R_CHANCES = [0.8, 0.7, 0.4, 0.75, 0.6, 0.5, 0.8, 0.55, 0.2, 0.5, 0.3, 0.4, 0.9, 0.45, 0.3, 0.4, 0.6, 0.3, 0.65, 0.2]
const N_CHANCES = [0.4, 0.3, 0.1, 0.3, 0.45, 0.2, 0.4, 0.25, 0.1, 0.3, 0.15, 0.2, 0.6, 0.2, 0.15, 0.15, 0.35, 0.15, 0.25, 0.1]
const R_VALS = [50, 40, 20, 35, 25, 20, 35, 22, 6, 20, 10, 15, 50, 23, 15, 20, 30, 13, 32, 10]
const N_VALS = [20, 20, 5, 15, 15, 10, 17, 8, 3, 10, 5, 7, 25, 11, 7, 7, 15, 5, 12, 4]
const S_VALS = [8, 5, 2, 2, 3, 2, 4, 2, 1, 3, 2, 3, 10, 3, 3, 2, 3, 1, 4, 1]
const POINT_TYPES = ['P', 'E', 'E', 'E', 'M', 'M', 'E', 'E', 'P', 'P', 'E', 'P', 'M', 'M', 'E', 'E', 'E', 'M', 'P', 'P']
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
var playing
var colr_pos
var coln_pos
var cols_pos
var _in_column
var col
var home
var start_dying
var dying
var beginning_scale

func init(card_id, pos, colr, coln, cols):
	card = CARDS[card_id]
	r_chance = R_CHANCES[card_id]
	n_chance = N_CHANCES[card_id]
	r_val = R_VALS[card_id]
	n_val = N_VALS[card_id]
	s_val = S_VALS[card_id]
	point_type = POINT_TYPES[card_id]
	print("Point Type: ", point_type)
	$AnimatedSprite.animation = card
	position = pos
	embiggening = false
	t = 0.0
	playing = false
	colr_pos = colr
	coln_pos = coln
	cols_pos = cols
	col = 'S'
	home = pos
	dying = false

func _process(delta):
	if not playing:	
		# Card Scaling Code
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
			
		if start_dying:
			t = 0
			dying = true
			start_dying = false
			beginning_scale = scale.x
		if dying:
			t += delta
			scale.x = clamp(beginning_scale - t, 0, beginning_scale)
			scale.y = clamp(beginning_scale - t, 0, beginning_scale)
			dying = scale.x > 0.002
			if not dying:
				emit_signal("turn_done")
				queue_free()

func play():
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
		if not _in_column:
			if playing:
				scale.x = 0.5
				scale.y = 0.5
				playing = false
			else:
				scale.x = 0.6
				scale.y = 0.6
				playing = true
		else:
			move(home)
			_in_column = false
			emit_signal("out_of_column")

func move_to_colr():
	if playing and get_tree().get_root().get_node("Game").can_card_play():
		position = colr_pos.position
		playing = false
		_in_column = true
		col = 'R'
		emit_signal("in_column")

func move_to_coln():
	if playing and get_tree().get_root().get_node("Game").can_card_play():
		position = coln_pos.position
		playing = false
		_in_column = true
		col = 'N'
		emit_signal("in_column")

func move_to_cols():
	if playing and get_tree().get_root().get_node("Game").can_card_play():
		position = cols_pos.position
		playing = false
		_in_column = true
		emit_signal("in_column")

func play_card():
	if _in_column:
		var play_value = play()
		get_tree().get_root().get_node("Game").update_resources(point_type, play_value)
		start_dying = true
		minimizing = false
		embiggening = false

func move_home():
	move(home)
