extends RigidBody2D

@export
var movement_speed : float
@export
var acceleration : float
@export
var offset_magnitude_range : float

@onready
var physics_component : PhysicsComponent = get_node("PhysicsComponent")

enum STATE {
	CHASING,
	BLINE
}

var current_state = STATE.CHASING

var chasing_offset = Vector2.ZERO

var player_position: Vector2

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	player_position = Game.player.global_position
	
	if current_state == STATE.CHASING and chasing_offset == Vector2.ZERO:
		var angle = randf() * TAU
		chasing_offset = Vector2.RIGHT.rotated(angle) * offset_magnitude_range
	
	if current_state == STATE.CHASING:
		player_position += chasing_offset
		
	var direction = (player_position - global_position).normalized()
	var current_velocity = state.linear_velocity
	var target_velocity = direction * movement_speed
	
	
	if direction.length() > 0:
		current_velocity = current_velocity.move_toward(target_velocity, acceleration * state.step)
		
	if player_position.x < global_position.x:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	
	if current_velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

	physics_component.base_velocity = current_velocity
	state.linear_velocity = physics_component.velocity


func _on_body_entered(body: Node) -> void:
	if body == Game.player:
		print(chasing_offset)
		current_state = STATE.BLINE
		chasing_offset = Vector2.ZERO


func _on_body_exited(body: Node) -> void:
	if body == Game.player:
		current_state = STATE.CHASING
