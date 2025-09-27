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
var gun_names = ["pistol", "smg", "sniper", "tommy", "sawedoff", "bacon"]
var gun_num = 0

var DEBUG = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
