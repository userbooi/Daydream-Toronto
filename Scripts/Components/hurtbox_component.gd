class_name HurtboxComponent
extends Area2D


signal hurt(hitbox_component: HitboxComponent)

@onready var parent: Node2D = get_parent()


func recieve_hit(hitbox_component: HitboxComponent) -> void:
	var health_component: HealthComponent = parent.health_component
	if health_component.take_damage(hitbox_component.damage):
		hurt.emit(hitbox_component)
		#Game.game_manager.spawn_damage_number(hitbox_component.global_position, hitbox_component.damage)
		flash_sprite()
		recieve_knockback(hitbox_component)


func flash_sprite() -> void:
	const FLASH_DURATION: float = 0.12
	var sprite: AnimatedSprite2D = parent.get_node("AnimatedSprite2D")
	var mat: ShaderMaterial = sprite.material
	
	if mat:
		var total_time: float = max(parent.iframes_duration, FLASH_DURATION)
		var iterations: int = int(ceil(total_time / FLASH_DURATION / 2))
		
		for i: int in range(iterations):
			mat.set_shader_parameter("enabled", true)
			await get_tree().create_timer(FLASH_DURATION).timeout
			mat.set_shader_parameter("enabled", false)
			
			if i < iterations - 1:
				await get_tree().create_timer(FLASH_DURATION).timeout


func recieve_knockback(hitbox_component: HitboxComponent) -> void:
	var direction: Vector2 = (parent.global_position - hitbox_component.original_position).normalized()
	var knockback_force: Vector2 = direction * hitbox_component.knockback_force * 5
	parent.physics_component.impulse_velocity += knockback_force


#func _process(delta: float) -> void:
	#var overlapping_bodies: Array = get_overlapping_bodies()
	#for body in overlapping_bodies:
		#if not is_instance_valid(body.hitbox_component):
			#continue
		#var hitbox_component: HitboxComponent = body.hitbox_component
		#print("process hit")
		#recieve_hit(hitbox_component)
