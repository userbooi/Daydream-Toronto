extends Node2D

@export var bullet: PackedScene
@export var firerate: float

<<<<<<< HEAD
@export var fire = true

=======
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
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
<<<<<<< HEAD
	if Game.gun_num != 1 and Game.gun_num != 3:
		if Input.is_action_just_pressed("fire") and fire:
			fire = false
			shoot()
			$Timer.start()
	else:
		if Input.is_action_pressed("fire") and fire:
			fire = false
			shoot()
			$Timer.start()
=======
	if Input.is_action_just_pressed("fire"):
		shoot()
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a

#@export var speed: float
#@export var damage: int
#@export var maxrange: float
#@export var knockback: float
func shoot():
	var bullet_instance = bullet.instantiate()
	
	bullet_instance.scale = Vector2(0.15, 0.15)
	bullet_instance.global_position = $Sprite2D/shootPoint.global_position
	bullet_instance.global_rotation = $Sprite2D/shootPoint.global_rotation
	bullet_instance.starting_point = global_position
	bullet_instance.speed = Game.gun_stats[Game.gun_names[Game.gun_num]][0]
	bullet_instance.damage = Game.gun_stats[Game.gun_names[Game.gun_num]][1]
	bullet_instance.maxrange = Game.gun_stats[Game.gun_names[Game.gun_num]][2]
	bullet_instance.knockback = Game.gun_stats[Game.gun_names[Game.gun_num]][3]
	get_node("/root/Main/Projectiles").add_child(bullet_instance)
<<<<<<< HEAD

func detect_angle():
	if (get_global_mouse_position().x < Game.player.position.x):
		$Sprite2D.scale = Vector2(1, -1)
		position = Vector2(-5,0)
	else:
=======
	#$bullets.add_child(bullet_instance)

func detect_angle():
	if (get_global_mouse_position().x < Game.player.position.x):
		#$Sprite2D.flip_v = true
		$Sprite2D.scale = Vector2(1, -1)
		position = Vector2(-5,0)
		#$shootPoint.position.y = 
	else:
		#$Sprite2D.flip_v = false
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
		$Sprite2D.scale = Vector2(1, 1)
		position = Vector2(5, 0)
				
func change_gun():
<<<<<<< HEAD
	var img = Game.crosshair_sprites[Game.gun_names[Game.gun_num]].get_image()
	img.resize(img.get_width() * 3, img.get_height() * 3, Image.INTERPOLATE_NEAREST)  # scale ×2
=======
	var offsetVector
	var img = Game.crosshair_sprites[Game.gun_names[Game.gun_num]].get_image()
	img.resize(img.get_width() * 2, img.get_height() * 2, Image.INTERPOLATE_NEAREST)  # scale ×2
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
	var scaled_tex := ImageTexture.create_from_image(img)
	
	if Game.gun_num == 0:
		
		$Sprite2D.position = Vector2(3.8, -1.2)
<<<<<<< HEAD
=======
		offsetVector = Vector2(0, 40)
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
		$Sprite2D/shootPoint.position = Vector2(9.8, -3.9)
		
	elif Game.gun_num == 1:
		
		$Sprite2D.position = Vector2(4.533, -1.2)
<<<<<<< HEAD
=======
		offsetVector = Vector2(20, 12)
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
		$Sprite2D/shootPoint.position = Vector2(14.1, -1.8)
		
	elif Game.gun_num == 2:
		
		$Sprite2D.position = Vector2(9.6, -1.2)
<<<<<<< HEAD
=======
		offsetVector = Vector2(20, 12)
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
		$Sprite2D/shootPoint.position = Vector2(22, -4.4)
		
	elif Game.gun_num == 3:
		
		$Sprite2D.position = Vector2(6.467, -1.2)
<<<<<<< HEAD
=======
		offsetVector = Vector2(20, 12)
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
		$Sprite2D/shootPoint.position = Vector2(17, -4)
		
	elif Game.gun_num == 4:
		
		$Sprite2D.position = Vector2(4.267, -1.2)
<<<<<<< HEAD
		$Sprite2D/shootPoint.position = Vector2(12.6, -2.6)
=======
		offsetVector = Vector2(20, 12)
		$shootPoint.position = Vector2(12.6, -2.6)
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
		
	else:
		
		$Sprite2D.position = Vector2(8.3, -1.2)
<<<<<<< HEAD
		$Sprite2D/shootPoint.position = Vector2(14, -2.4)
=======
		$shootPoint.position = Vector2(14, -2.4)
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
		
	$Sprite2D.texture = Game.gun_sprites[Game.gun_names[Game.gun_num]]
	var hotspot = scaled_tex.get_size()/2
	Input.set_custom_mouse_cursor(scaled_tex, Input.CURSOR_ARROW, hotspot)
	firerate = Game.gun_stats[Game.gun_names[Game.gun_num]][4]
<<<<<<< HEAD
	$Timer.wait_time = firerate
	


func _on_timer_timeout() -> void:
	fire = true
=======
	
>>>>>>> fd3067d19631e60178072626b339e2af0acbe40a
