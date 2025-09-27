extends RigidBody2D

@export
var movement_speed : float
@export
var acceleration : float
@export
var friction : float

@onready
var physics_component : PhysicsComponent = get_node("PhysicsComponent")

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	pass
	
