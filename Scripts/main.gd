extends Node2D
signal sacrifice
signal next_wave

@onready var enemy = preload("res://Scenes/zombie.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.self_modulate.a = 0
	
	$enemySpawnTimer.wait_time = Game.spawn_time[Game.curr_level]
	$enemySpawnTimer.start()
	
	connect_signals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_inputs()
	check_enemy_left()

func check_inputs():
	if Input.is_action_just_pressed("sacrifice") and Game.player.curr_state == Game.player.STATES.ALIVE:
		sacrifice.emit()
		
func spawn_enemy(pos):
	var new_enemy = enemy.instantiate()
	new_enemy.position = pos
	if new_enemy.position.x < -2050 or new_enemy.position.x > 1000 or new_enemy.position.y < -500 or new_enemy.position.y > 830:
		return
	new_enemy.y_sort_enabled = true
	new_enemy.z_index = 0
	if check_spawn_area(pos):
		$Entities.add_child(new_enemy)
		Game.curr_enemy_num += 1

func check_spawn_area(spawn_pos) -> bool:
	var space_state = get_world_2d().direct_space_state
	
	# Create a small "check shape" (circle here, could also use a rectangle)
	var shape = CircleShape2D.new()
	shape.radius = 16  # adjust to enemy size
	
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = Transform2D(0, spawn_pos)
	query.collision_mask = 3  # adjust to match layers you want to avoid
	
	var result = space_state.intersect_shape(query)
	
	if result.size() == 0:
		return true
	else:
		return false

func _on_enemy_spawn_timer_timeout() -> void:
	if Game.curr_enemy_num < Game.enemies[Game.curr_level]:
		var spawn_path: PathFollow2D = $Player.get_node("enemySpawner/PathFollow2D")
		spawn_path.progress_ratio = randf()
		spawn_enemy(spawn_path.global_position)
	else:
		$enemySpawnTimer.stop()
	
func connect_signals():
	Game.player.connect("dead", Callable(self, "_start_death"))
	connect("sacrifice", Callable($CanvasLayer/Sanity, "_sac"))
	$CanvasLayer/Sanity.connect("sac_effects", Callable(Game.player, "_shrink_fov"))
	$CanvasLayer/Sanity.connect("sac_effects",  Callable(self, "_dim_lights"))
	$CanvasLayer/Sanity.connect("sac_effects", Callable(Game.player, "_upgrade"))
	$CanvasLayer/Sanity.connect("sac_end", Callable(Game.player, "_revert"))
	connect("next_wave", Callable(Game.player, "_redo_fov"))
	connect("next_wave", Callable($CanvasLayer/Sanity, "_add_sanity"))
	
func _dim_lights():
	#pass
	$WorldEnvironment/PointLight2D.energy += 0.07
	
func redo_lights():
	#pass
	$WorldEnvironment/PointLight2D.energy = 0.8
	
func _start_death():
	$enemySpawnTimer.stop()
	for node in get_node("Entities").get_children():
		node.freeze = true
		node.linear_velocity = Vector2.ZERO
	Game.player.freeze = true
	Game.player.z_index = 100
	$CanvasLayer/Sanity.visible = false
	$ColorRect.position = Vector2(Game.player.global_transform.origin.x - $ColorRect.size.x/2, Game.player.global_transform.origin.y - $ColorRect.size.y/2)
	$ColorRect/AnimationPlayer.play("death")
	await get_tree().create_timer(2).timeout
	for node in get_node("Entities").get_children():
		node.queue_free()
	Game.player.linear_velocity = Vector2.ZERO
	$Player/AnimatedSprite2D.play("death")
	$CanvasLayer/AnimationPlayer.play("start")
	print("HI")
	
func check_enemy_left():
	if Game.enemy_killed == Game.enemies[Game.curr_level]:
		next_level()
		
func next_level():
	if Game.curr_level < 3:
		Game.curr_level += 1
		next_wave.emit()
		redo_lights()
		await get_tree().create_timer(1).timeout
		Game.curr_enemy_num = 0
		Game.enemy_killed = 0
		$enemySpawnTimer.wait_time = Game.spawn_time[Game.curr_level]
		$enemySpawnTimer.start()
	else:
		print("WIN")
	
