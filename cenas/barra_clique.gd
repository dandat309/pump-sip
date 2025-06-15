extends ProgressBar
func _ready() -> void:
	animaTween()
var instancia
func animaTween():
	if instancia == null:
		add_child(instancia)
	var open = create_tween()
	open.tween_property(self, "value",JogoScript.contador, 0.1).set_delay(0.2)
