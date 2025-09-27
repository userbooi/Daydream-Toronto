extends CharacterBody2D

@export var speed: float
@export var damage: int
@export var maxrange: float
@export var knockback: float
@export var travelled: float = 0
var time_alive = 0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var starting_point: Vector2
var end_point: Vector2

func _ready() -> void:
	end_point = get_global_mouse_position()

func set_pos(pos: Vector2):
	position = pos
	$Timer.start()

func _process(delta: float) -> void:
	check_distance(delta)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = end_point - starting_point
	velocity = direction.normalized() * speed

	move_and_slide()

func check_distance(delta: float) -> void:
	if time_alive * speed * delta > maxrange:
		queue_free()

#func _physics_process(delta: float) -> void:
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()


func _on_timer_timeout() -> void:
	time_alive += 0.1
