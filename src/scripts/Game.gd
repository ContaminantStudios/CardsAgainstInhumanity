extends Node2D

func _ready():
	pass

func make_card():
	var card_scene = preload("res://scenes/Card.tscn")
	var card_node = card_scene.instance()
	card_node.init(0, Vector2(0, 0))
	add_child(card_node)
