extends Node2D
class_name Effect

signal stack_added()

var effect_instance: EffectInstance
var container: EffectComponent
var stacks: int = 1

func add_stack(amount: int = 1) -> void:
	if stacks < effect_instance.max_stacks:
		stacks += amount
	stack_added.emit()

func _exit_tree() -> void:
	container.remove_effect(self)
