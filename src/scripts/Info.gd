extends CanvasLayer

var current_label
var current_button

func _ready():
	$Back.disabled = true
	current_label = 'Rules'
	current_button = 'Next'

func show_all():
	$ColorRect.show()
	show_current_label()
	$Back.disabled = false
	match current_button:
		'Next':
			$Next.disabled = false
		'Prev':
			$Previous.disabled = false
	$EducationIcon.show()
	$PoliticalIcon.show()
	$MilitaryIcon.show()

func hide_all():
	$ColorRect.hide()
	hide_current_label()
	$Back.disabled = true
	$Next.disabled = true
	$Previous.disabled = true
	$EducationIcon.hide()
	$PoliticalIcon.hide()
	$MilitaryIcon.hide()

func next_pressed():
	$Rules.hide()
	$Controls.show()
	current_label = 'Controls'
	current_button = 'Prev'
	$Next.disabled = true
	$Previous.disabled = false
	$EducationIcon.hide()
	$PoliticalIcon.hide()
	$MilitaryIcon.hide()

func previous_pressed():
	$Controls.hide()
	$Rules.show()
	current_label = 'Rules'
	current_button = 'Next'
	$Next.disabled = false
	$Previous.disabled = true
	$EducationIcon.show()
	$PoliticalIcon.show()
	$MilitaryIcon.show()

func show_current_label():
	match current_label:
		'Rules':
			$Rules.show()
		'Controls':
			$Controls.show()

func hide_current_label():
	match current_label:
		'Rules':
			$Rules.hide()
		'Controls':
			$Controls.hide()
