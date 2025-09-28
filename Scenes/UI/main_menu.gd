extends Control

@onready
var play_button = $BoxContainer/Play
@onready
var exit_button = $BoxContainer/Exit


func _on_play_pressed() -> void:
	Game.switch_scene("res://Scenes/main.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
