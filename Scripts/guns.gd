extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_gun()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	handle_inputs()
	detect_angle()
	
func handle_inputs():
	if Game.DEBUG:
		if Input.is_action_just_pressed("switch_weapon"):
			if Game.gun_num < 5:
				Game.gun_num += 1
			else:
				Game.gun_num = 0
			change_gun()

func detect_angle():
	if (get_global_mouse_position().x < Game.player.position.x):
		$Sprite2D.flip_v = true
	else:
		$Sprite2D.flip_v = false
				
func change_gun():
	var offsetVector
	var img = Game.crosshair_sprites[Game.gun_names[Game.gun_num]].get_image()
	img.resize(img.get_width() * 3, img.get_height() * 3)  # scale ×2
	var scaled_tex := ImageTexture.create_from_image(img)
	
	if Game.gun_num == 0:
		$Sprite2D.position = Vector2(3.8, -1.2)
		offsetVector = Vector2(20, 12)
	elif Game.gun_num == 1:
		$Sprite2D.position = Vector2(4.533, -1.2)
		offsetVector = Vector2(20, 12)
	elif Game.gun_num == 2:
		$Sprite2D.position = Vector2(9.6, -1.2)
		offsetVector = Vector2(20, 12)
	elif Game.gun_num == 3:
		$Sprite2D.position = Vector2(6.467, -1.2)
		offsetVector = Vector2(20, 12)
	elif Game.gun_num == 4:
		$Sprite2D.position = Vector2(4.267, -1.2)
		offsetVector = Vector2(20, 12)
	else:
		$Sprite2D.position = Vector2(8.3, -1.2)
		offsetVector = Vector2(20, 12)
	$Sprite2D.texture = Game.gun_sprites[Game.gun_names[Game.gun_num]]
	Input.set_custom_mouse_cursor(scaled_tex, Input.CURSOR_ARROW, offsetVector)
	
