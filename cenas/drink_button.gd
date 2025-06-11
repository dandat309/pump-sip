extends Button
func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.2, 0.6, 0.9) # Cor de fundo do botão
	style.corner_radius_top_left = 16
	style.corner_radius_top_right = 16
	style.corner_radius_bottom_left = 16
	style.corner_radius_bottom_right = 16
	style.set_border_width(SIDE_LEFT, 2)
	style.set_border_width(SIDE_TOP, 2)
	style.set_border_width(SIDE_RIGHT, 2)
	style.set_border_width(SIDE_BOTTOM, 2)	
