extends Node2D
signal sacrifice

@onready var enemy = preload("res://Scenes/zombie.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$enemySpawnTimer.wait_time = Game.spawn_time[Game.curr_level]
	$enemySpawnTimer.start()
	
	connect_signals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_inputs()
	
func check_inputs():
	if Input.is_action_just_pressed("sacrifice"):
		sacrifice.emit()
		
func spawn_enemy(pos):
	var new_enemy = enemy.instantiate()
	new_enemy.position = pos
	$Entities.add_child(new_enemy)

func _on_enemy_spawn_timer_timeout() -> void:
	if Game.curr_enemy_num < Game.enemies[Game.curr_level]:
		var spawn_path: PathFollow2D = $Player.get_node("enemySpawner/PathFollow2D")
		spawn_path.progress_ratio = randf()
		spawn_enemy(spawn_path.global_position)
		Game.curr_enemy_num += 1
	else:
		$enemySpawnTimer.stop()
		
func connect_signals():
	connect("sacrifice", Callable($CanvasLayer/Sanity, "_sac"))
	$CanvasLayer/Sanity.connect("sac_effects", Callable(Game.player, "_shrink_fov"))
	$CanvasLayer/Sanity.connect("sac_effects",  Callable(self, "_dim_lights"))
	
func _dim_lights():
	$WorldEnvironment/PointLight2D.energy += 0.1
