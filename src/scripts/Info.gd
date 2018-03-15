extends CanvasLayer

func _ready():
	$Button.disabled = true

func show_all():
	$ColorRect.show()
	$Label.show()
	$Button.disabled  = false

func hide_all():
	$ColorRect.hide()
	$Label.hide()
	$Button.disabled = true
