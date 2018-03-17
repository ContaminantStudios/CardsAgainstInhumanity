extends Node2D

signal colr_selected
signal coln_selected
signal cols_selected
signal card_in_column
signal card_played

var _card_in_column
var p
var e
var m
var turns

func _ready():
	p = 0
	e = 0
	m = 0
	turns = 20
	make_card(1, 1)
	_card_in_column = false
	$UI/PlayButton.disabled = true

func make_card(pos, id):
	var card_scene = preload("res://scenes/Card.tscn")
	var card_node = card_scene.instance()
	match pos:
		2:
			card_node.init(0, $CardPos2.position, $ColRPos, $ColNPos, $ColSPos)
		3:
			card_node.init(0, $CardPos3.position, $ColRPos, $ColNPos, $ColSPos)
		4:
			card_node.init(0, $CardPos4.position, $ColRPos, $ColNPos, $ColSPos)
		5:
			card_node.init(0, $CardPos5.position, $ColRPos, $ColNPos, $ColSPos)
		_:
			card_node.init(0, $CardPos1.position, $ColRPos, $ColNPos, $ColSPos)
	self.connect("colr_selected", card_node, "move_to_colr")
	self.connect("coln_selected", card_node, "move_to_coln")
	self.connect("cols_selected", card_node, "move_to_cols")
	self.connect("card_played", card_node, "play_card")
	card_node.connect("in_column", self, "set_can_card_play_false")
	card_node.connect("out_of_column", self, "set_can_card_play_true")
	card_node.connect("turn_done", self, "complete_turn")
	add_child(card_node)

func colr_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		emit_signal("colr_selected")

func coln_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		emit_signal("coln_selected")

func cols_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		emit_signal("cols_selected")

func set_can_card_play_false():
	print("Cards can't be played")
	_card_in_column = true
	$UI/PlayButton.disabled = false

func set_can_card_play_true():
	print("Cards can be played")
	_card_in_column = false
	$UI/PlayButton.disabled = true

func can_card_play():
	return not _card_in_column

func play_button_pressed():
	emit_signal("card_played")

func update_resources(type, val):
	match type:
		'P':
			p += val
		'E':
			e += val
		'M':
			m += val
		_:
			print("Lol, ya messed up. Something ain't right on one of the card types.")
	print("P: ", p, ", E: ", e, ", M: ", m)

func complete_turn():
	turns -= 1
	$UI/Turns.text = str("Turns: ", turns)
	_card_in_column = false
