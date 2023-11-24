extends Effect

# Give increased movement speed to the player based
# on the number of blood stacks that the player has.

@export var attack_speed_per_stack: float = 0.01
@export var blood_instance: EffectInstance
var blood_effect: Effect


func _process(delta):
	if blood_effect:
		return
	blood_effect = container.get_effect(blood_instance)
	if blood_effect:
		on_blood_stack_changed(blood_effect.stacks)
		blood_effect.stack_changed.connect(on_blood_stack_changed)
		blood_effect.exited_tree.connect(on_blood_stack_exited)


func add_stack() -> void:
	if stacks < effect_instance.max_stacks:
		stacks += 1
	stack_changed.emit(1)
	if blood_effect:
		clear_effect()
		on_blood_stack_changed(blood_effect.stacks)


func get_description() -> String:
	var effect = attack_speed_per_stack*stacks*100
	var desc = "[b]Attack Speed[/b]: +%s" % effect
	return desc+"%"


func clear_effect() -> void:
	if blood_effect:
		container.stats_component.attack_speed_mult -= blood_effect.stacks * (stacks-1) * attack_speed_per_stack


func on_blood_stack_changed(change: int) -> void:
	container.stats_component.attack_speed_mult += change * stacks * attack_speed_per_stack


func on_blood_stack_exited(effect: Effect) -> void:
	blood_effect = null
