extends Control
signal sac_effects
signal sac_end

const max_time = 10
var sacable = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureProgressBar.value = 140


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _sac():
	if sacable and $TextureProgressBar.value >= 20:
		$TextureProgressBar.value -= 20
		sac_effects.emit()
		$Timer.wait_time = max_time * ($TextureProgressBar.value/$TextureProgressBar.max_value)
		$Timer.start()
		sacable = false


func _on_timer_timeout() -> void:
	sacable = true
	sac_end.emit()
	
func _add_sanity():
	$TextureProgressBar.value += 40
