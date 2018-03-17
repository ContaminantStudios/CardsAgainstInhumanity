extends Node2D

signal colr_selected
signal coln_selected
signal cols_selected
signal card_in_column
signal card_played
signal turn_passed

var _card_in_column
var p
var e
var m
var turns
var last_five_cards
var cards

func _ready():
	p = 0
	e = 0
	m = 0
	turns = 20
	_card_in_column = false
	$UI/PlayButton.disabled = true
	last_five_cards = [-1, -1, -1, -1, -1]
	cards = [0, 0, 0, 0, 0]
	draw_card()

func _process(delta):
	$MilitaryPoints.text = str(clamp(m, 0, 100), " / 100")
	$EducationPoints.text = str(clamp(e, 0, 100), " / 100")
	$PoliticalPoints.text = str(clamp(p, 0, 100), " / 100")
	if m >= 100 or e >= 100 or p >= 100:
		win()
	if turns == 0:
		lose()

func make_card(pos, id):
	var card_scene = preload("res://scenes/Card.tscn")
	var card_node = card_scene.instance()
	match pos:
		2:
			card_node.init(id, $CardPos2.position, $ColRPos, $ColNPos, $ColSPos, pos)
			cards[1] = 1
		3:
			card_node.init(id, $CardPos3.position, $ColRPos, $ColNPos, $ColSPos, pos)
			cards[2] = 1
		4:
			card_node.init(id, $CardPos4.position, $ColRPos, $ColNPos, $ColSPos, pos)
			cards[3] = 1
		5:
			card_node.init(id, $CardPos5.position, $ColRPos, $ColNPos, $ColSPos, pos)
			cards[4] = 1
		_:
			card_node.init(id, $CardPos1.position, $ColRPos, $ColNPos, $ColSPos, pos)
			cards[0] = 1
	self.connect("colr_selected", card_node, "move_to_colr")
	self.connect("coln_selected", card_node, "move_to_coln")
	self.connect("cols_selected", card_node, "move_to_cols")
	self.connect("card_played", card_node, "play_card")
	self.connect("turn_passed", card_node, "move_home")
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
			p = clamp(p + val, 0, 100)
		'E':
			e = clamp(e + val, 0, 100)
		'M':
			m = clamp(m + val, 0, 100)
		_:
			print("Lol, ya messed up. Something ain't right on one of the card types.")
	print("P: ", p, ", E: ", e, ", M: ", m)

func complete_turn():
	turns = clamp(turns - 1, 0, 20)
	$UI/Turns.text = str("Turns: ", turns)
	_card_in_column = false
	if cards.has(0):
		draw_card()

func pass_button_pressed():
	emit_signal("turn_passed")
	turns = clamp(turns - 1, 0, 20)
	$UI/Turns.text = str("Turns: ", turns)
	if cards.has(0):
		draw_card()
	if cards.has(0):
		draw_card()

func draw_card():
	var cardNotDrawn = true
	while cardNotDrawn:
		var id = randi() % 24
		var pos = cards.find(0) + 1
		if !last_five_cards.has(id) and pos <= 5:
			print("Cards before draw: ", cards, "\nCards after draw: ", cards)
			make_card(pos, id)
			cardNotDrawn = false
			last_five_cards.pop_back()
			last_five_cards.push_front(id)
			print("Card drawn at pos ", pos, " and id ", id)

func discard(pos):
	cards[pos - 1] = 0
	print("Discarding at position ", pos)

func win():
	print("win")

func lose():
	print("lose")
