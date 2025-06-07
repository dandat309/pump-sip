extends Node2D

@onready var label = $Label

func set_number(n: int):
	label.text = str(n)
