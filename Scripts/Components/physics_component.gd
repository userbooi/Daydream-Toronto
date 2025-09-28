class_name PhysicsComponent
extends Node

@onready var parent = get_parent()

var base_velocity: Vector2 = Vector2.ZERO
var impulse_velocity: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	impulse_velocity = impulse_velocity.move_toward(Vector2.ZERO, delta * 500)
	velocity = base_velocity + impulse_velocity
	
