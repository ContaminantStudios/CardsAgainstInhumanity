extends Node2D

func _ready():
	make_card(1, 1)
	make_card(2, 1)
	make_card(3, 1)
	make_card(4, 1)
	make_card(5, 1)

func make_card(pos, id):
	var card_scene = preload("res://scenes/Card.tscn")
	var card_node = card_scene.instance()
	card_node.init(0, Vector2(0, 0))
	match pos:
		2:
			$CardPos2.add_child(card_node)
		3:
			$CardPos3.add_child(card_node)
		4:
			$CardPos4.add_child(card_node)
		5:
			$CardPos5.add_child(card_node)
		_:
			$CardPos1.add_child(card_node)



func colr_mouse_entered():
	print("Mouse Entered Column R")


func coln_mouse_entered():
	print("Mouse Entered Column N")


func cols_mouse_entered():
	print("Mouse Entered Column S")
