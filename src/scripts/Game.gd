extends Node2D

signal colr_selected
signal coln_selected
signal cols_selected
signal card_played
signal card_in_column

var card_pos_1
var card_pos_2
var card_pos_3
var card_pos_4
var card_pos_5
var _card_in_column

func _ready():
	make_card(1, 1)
	make_card(2, 1)
	make_card(3, 1)
	make_card(4, 1)
	make_card(5, 1)
	_card_in_column = false

func make_card(pos, id):
	var card_scene = preload("res://scenes/Card.tscn")
	var card_node = card_scene.instance()
	match pos:
		2:
			card_node.init(0, $CardPos2.position, $ColRPos, $ColNPos, $ColSPos)
			card_pos_2 = card_node
		3:
			card_node.init(0, $CardPos3.position, $ColRPos, $ColNPos, $ColSPos)
			card_pos_3 = card_node
		4:
			card_node.init(0, $CardPos4.position, $ColRPos, $ColNPos, $ColSPos)
			card_pos_4 = card_node
		5:
			card_node.init(0, $CardPos5.position, $ColRPos, $ColNPos, $ColSPos)
			card_pos_5 = card_node
		_:
			card_node.init(0, $CardPos1.position, $ColRPos, $ColNPos, $ColSPos)
			card_pos_1 = card_node
	self.connect("colr_selected", card_node, "move_to_colr")
	self.connect("coln_selected", card_node, "move_to_coln")
	self.connect("cols_selected", card_node, "move_to_cols")
	card_node.connect("in_column", self, "set_can_card_play_false")
	card_node.connect("out_of_column", self, "set_can_card_play_true")
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

func set_can_card_play_true():
	print("Cards can be played")
	_card_in_column = false

func can_card_play():
	return not _card_in_column
