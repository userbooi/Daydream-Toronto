extends RigidBody2D
signal dead

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

@onready var og_zoom = $Camera2D.zoom
@onready var curr_zoom = $Camera2D.zoom

enum STATES {ALIVE, DEAD}
var curr_state = STATES.ALIVE

var gotDead = false

func _ready() -> void:
	gotDead = false
	Game.player = self
	freeze = false
	z_index = 0
	$guns.visible = true

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if curr_state == STATES.ALIVE:
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
	elif !gotDead:
		$guns.visible = false
		gotDead = true
		freeze = true
		dead.emit()


func _on_died() -> void:
	curr_state = STATES.DEAD
	
	
func _shrink_fov():
	while $Camera2D.zoom.x <= curr_zoom.x * 1.2:
		$Camera2D.zoom += Vector2(0.01, 0.01)
		await get_tree().create_timer(0.02).timeout
	curr_zoom = $Camera2D.zoom
	
func _redo_fov():
	while $Camera2D.zoom.x > og_zoom.x:
		$Camera2D.zoom -= Vector2(0.01, 0.01)
		await get_tree().create_timer(0.01).timeout
	curr_zoom = $Camera2D.zoom

func _upgrade():
	var gun_num = round((randf() * 3) + 1)
	$guns.set_gun(gun_num)
	
func _revert():
	$guns.set_gun(0)
	
