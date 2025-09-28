extends ProgressBar

@onready
var parent = get_parent()

func _process(delta: float) -> void:
	value = parent.health_component.current_health
