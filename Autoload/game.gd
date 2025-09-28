extends Node

var gun_sprites: Dictionary = {
	"pistol": preload("res://Assets/guns/pistol.png"),
	"smg": preload("res://Assets/guns/smg.png"),
	"sniper": preload("res://Assets/guns/sniper.png"),
	"tommy": preload("res://Assets/guns/tommy.png"),
	"sawedoff": preload("res://Assets/guns/sawedoff.png"),
	"bacon": preload("res://Assets/guns/bacon.png")
}
var crosshair_sprites: Dictionary = {
	"pistol": preload("res://Assets/crosshair/pistol_crosshair.png"),
	"smg": preload("res://Assets/crosshair/smg_crosshair.png"),
	"sniper": preload("res://Assets/crosshair/sniper_crosshair.png"),
	"tommy": preload("res://Assets/crosshair/tommy_crosshair.png"),
	"sawedoff": preload("res://Assets/crosshair/sawedoff_crosshair.png"),
	"bacon": preload("res://Assets/crosshair/bacon_cross.png")
}
var gun_stats: Dictionary = {
	"pistol":   [200, 34, 2, 20, 0.5, 1, 0],
	"smg":      [300, 20, 1.5, 15, 0.1, 1, PI/15],
	"sniper":   [800, 100, 5, 100, 1.5, 1, 0],
	"tommy":    [250, 40, 2, 20, 0.27, 1, 0],
	"sawedoff": [350, 70, 1, 10, 1, 5, PI/12],
	"bacon":    [100, 100000, 0.5, 0, 0.05, 100, 4 *PI],
}
#@export var speed: float
#@export var damage: int
#@export var maxrange: float
#@export var knockback: float
# fire rate
# # of bullets
# spread true/false
var gun_names = ["pistol", "smg", "sniper", "tommy", "sawedoff", "bacon"]
var gun_num = 0
var bullet = preload("res://Assets/guns/bullet.png")

var DEBUG = true

var player
var current_scene: Node

var enemies: Array[int] = [10, 25, 35, 50]
var curr_level = 0

var spawn_time = [0.5, 0.25, 0.15, 0.1]

var curr_enemy_num = 0
var enemy_killed = 0

func _ready() -> void:
	var root: Node = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func switch_scene(scene_path: String) -> void:
	call_deferred("_deferred_switch_scene", scene_path)
	

func _deferred_switch_scene(scene_path: String) -> void:
	current_scene.free()
	var scene: PackedScene = load(scene_path)
	current_scene = scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
