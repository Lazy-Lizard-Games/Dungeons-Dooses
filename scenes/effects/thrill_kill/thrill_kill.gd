extends Effect

# Give increased stamina regen to the player based
# on the number of blood stacks that the player has.
# Could remove the previous stamina regen increase 
# before adding the new stamina regen increase.
# Need access to the number of blood stacks that
# the player currently has.

@export var stamina_regen_per_stack: float = 0.025
@export var bloodlust_instance: EffectInstance
@export var blood_instance: EffectInstance
var blood_effect: Effect


func _ready():
	if bloodlust_instance:
		container.add_effect(bloodlust_instance)


func _process(delta):
	if blood_effect:
		return
	blood_effect = container.get_effect(blood_instance)
	if blood_effect:
		on_blood_stack_changed(blood_effect.stacks)
		blood_effect.stack_changed.connect(on_blood_stack_changed)
		blood_effect.exited_tree.connect(on_blood_stack_exited)


func _add_stack() -> void:
	if stacks < effect_instance.max_stacks:
		stacks += 1
	stack_changed.emit(1)
	if blood_effect:
		container.stats_component.stamina_regen_mult -= blood_effect.stacks * (stacks-1) * stamina_regen_per_stack
		on_blood_stack_changed(blood_effect.stacks)


func on_blood_stack_changed(change: int) -> void:
	container.stats_component.stamina_regen_mult += change * stacks * stamina_regen_per_stack


func on_blood_stack_exited(effect: Effect) -> void:
	blood_effect = null
