extends Node2D

signal colr_selected

var card_pos_1
var card_pos_2
var card_pos_3
var card_pos_4
var card_pos_5

func _ready():
	make_card(1, 1)
	make_card(2, 1)
	make_card(3, 1)
	make_card(4, 1)
	make_card(5, 1)

func make_card(pos, id):
	var card_scene = preload("res://scenes/Card.tscn")
	var card_node = card_scene.instance()
	match pos:
		2:
			card_node.init(0, $CardPos2.position)
			card_pos_2 = card_node
		3:
			card_node.init(0, $CardPos3.position)
			card_pos_3 = card_node
		4:
			card_node.init(0, $CardPos4.position)
			card_pos_4 = card_node
		5:
			card_node.init(0, $CardPos5.position)
			card_pos_5 = card_node
		_:
			card_node.init(0, $CardPos1.position)
			card_pos_1 = card_node
	add_child(card_node)
#	self.connect("colr_selected", card_node, 

func colr_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		emit_signal("colr_selected")
