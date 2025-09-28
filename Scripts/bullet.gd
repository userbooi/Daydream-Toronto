extends CharacterBody2D

@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var physics_component: PhysicsComponent = $PhysicsComponent

@export var speed: float
@export var damage: int
@export var maxrange: float
@export var knockback_force: float

var time_alive = 0
var multiplier = 3

const SPEED = 300.0
var starting_point: Vector2
var end_point: Vector2
var original_position: Vector2

var has_hit = false

func _ready() -> void:
	end_point = get_global_mouse_position()
	hitbox_component.original_position = original_position

func set_pos(pos: Vector2):
	position = pos
	$Timer.start()

func _process(delta: float) -> void:
	check_distance(delta)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = end_point - starting_point
	velocity = direction.normalized() * speed * multiplier

	move_and_slide()

func check_distance(delta: float) -> void:
	if time_alive > maxrange:
		queue_free()

#func _physics_process(delta: float) -> void:
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()


func _on_timer_timeout() -> void:
	time_alive += 0.1


func _on_hitbox_component_hit(hurtbox: HurtboxComponent) -> void:
	has_hit = true
	queue_free()
