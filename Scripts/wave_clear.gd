extends AnimationPlayer


@onready
var parent: RichTextLabel = get_parent()

func _ready() -> void:
	parent.modulate.a = 0
	
func _on_main_next_wave() -> void:
	play("start")
