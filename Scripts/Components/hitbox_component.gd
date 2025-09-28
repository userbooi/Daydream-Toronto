class_name HitboxComponent
extends Area2D


signal hit(hurtbox: HurtboxComponent)

@onready var parent: Node2D = get_parent()

var damage: float
var knockback_force: float
var original_position: Vector2
var hit_list: Array


func _ready() -> void:
	damage = parent.damage
	knockback_force = parent.knockback_force


func _process(delta: float) -> void:
	hit_list = get_overlapping_areas()
	if hit_list:
		var closest: HurtboxComponent = hit_list[0]
		for hurtbox in hit_list:
			if original_position.distance_to(hurtbox.global_position) < original_position.distance_to(closest.global_position):
				closest = hurtbox
		hit.emit(closest)
		if not original_position:
			original_position = global_position
		closest.recieve_hit(self)
		if parent.name == "bullet":
			call_deferred("queue_free")
