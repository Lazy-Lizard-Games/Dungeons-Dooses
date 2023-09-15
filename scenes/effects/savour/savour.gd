extends Effect

@export var blood_instance: EffectInstance
@export var duration_per_point: float = 0.5


func _add_stack() -> void:
	stacks += 1
	if blood_instance:
		blood_instance.duration += duration_per_point


func _clear_effect() -> void:
	if blood_instance:
		blood_instance.duration -= stacks * duration_per_point


func _get_description() -> String:
	var effect = stacks * duration_per_point
	var desc = "[b]Duration[/b]: +%s" % effect
	return desc+"s"
