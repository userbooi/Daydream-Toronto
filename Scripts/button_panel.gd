extends BoxContainer


func _on_play_again_pressed() -> void:
	Game.reset_game()
	Game.switch_scene("res://Scenes/main.tscn")


func _on_back_pressed() -> void:
	Game.switch_scene("res://Scenes/UI/main_menu.tscn")
