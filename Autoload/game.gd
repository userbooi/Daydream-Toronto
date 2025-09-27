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
	"pistol": [200, 20, 400, 2000, 2],
	"smg": [200, 7, 400, 1500, 10],
	"sniper": [800, 100, 1200, 0, 1]
}
#@export var speed: float
#@export var damage: int
#@export var maxrange: float
#@export var knockback: float
# fire rate
#@export var travelled: float = 0
var gun_names = ["pistol", "smg", "sniper", "tommy", "sawedoff", "bacon"]
var gun_num = 0
var bullet = preload("res://Assets/guns/bullet.png")

var DEBUG = true

var player
var current_scene: Node

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
