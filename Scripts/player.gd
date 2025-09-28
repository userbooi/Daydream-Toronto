extends RigidBody2D

@onready
var health_component: HealthComponent = $HealthComponent
@export
var max_health : float

@onready
var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready
var physics_component : PhysicsComponent = $PhysicsComponent


@export
var movement_speed : float
@export
var acceleration : float
@export
var friction : float

@onready var curr_zoom = $Camera2D.zoom

func _ready() -> void:
	Game.player = self

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	var input_vector = Input.get_vector("left", "right", "up", "down").normalized()
	var current_velocity = state.linear_velocity
	var target_velocity = input_vector * movement_speed
	
	if input_vector.length() > 0:
		current_velocity = current_velocity.move_toward(target_velocity, acceleration * state.step)
	else:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, friction * state.step)
	
	if current_velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	
	if get_global_mouse_position().x < position.x:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

	physics_component.base_velocity = current_velocity
	state.linear_velocity = physics_component.velocity

	
func _on_death() -> void:
	Game.player = null
	queue_free()
	
func _shrink_fov():
	while $Camera2D.zoom.x <= curr_zoom.x * 1.2:
		$Camera2D.zoom += Vector2(0.01, 0.01)
		await get_tree().create_timer(0.02).timeout
	curr_zoom = $Camera2D.zoom
	
