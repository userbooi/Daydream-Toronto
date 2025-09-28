extends RigidBody2D

@onready var health_component: HealthComponent = $HealthComponent
@export var max_health: float

@onready var hitbox_component: HitboxComponent = $HitboxComponent
@export var damage: float
@export var knockback_force: float

@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

@onready var physics_component: PhysicsComponent = $PhysicsComponent

enum STATE {
	CHASING,
	BLINE
}

var current_state = STATE.CHASING

var chasing_offset = Vector2.ZERO

var player_position: Vector2

@export
var movement_speed : float
@export
var acceleration : float
@export
var offset_magnitude_range : float

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	if Game.player:
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
		current_state = STATE.BLINE
		chasing_offset = Vector2.ZERO


func _on_body_exited(body: Node) -> void:
	if body == Game.player:
		current_state = STATE.CHASING


func _on_died() -> void:
	Game.enemy_killed += 1
	queue_free()
	#death code here
	
#func _on_body_entered_me(body: Node):
	#if (body.name == "obstacles" or body.name == "crate1" or body.name == "crate2") and :
		#queue_free()
		#Game.curr_enemy_num -= 1
		#get_node("/root/Main/enemySpawnTimer").start()
	
