class_name HealthComponent
extends Node


signal died
signal healed(amount: float)
signal hurt(amount: float)

@onready var parent: Node2D = get_parent()


var max_health: float:
	set (value):
		max_health = value
		if current_health > max_health:
			current_health = max_health
var current_health: float:
	set (value):
		current_health = value
		if current_health > max_health:
			current_health = max_health
		if current_health <= 0 and not is_dead:
			just_died()
var is_dead: bool = false


func _ready() -> void:
	parent = get_parent()
	max_health = parent.max_health
	current_health = max_health


func take_damage(damage: float) -> bool:
	current_health -= damage
	emit_signal("hurt", damage)
	return true



func heal(heal_amount: float) -> void:
	emit_signal("healed", heal_amount)
	current_health += heal_amount


func set_health(new_health: float) -> void:
	current_health = new_health


func set_max_health(new_max_health: float) -> void:
	max_health = new_max_health


func reset_health() -> void:
	current_health = max_health


func just_died() -> void:
	is_dead = true
	emit_signal("died")
