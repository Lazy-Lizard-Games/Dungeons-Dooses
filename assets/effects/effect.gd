extends Node2D
class_name Effect

signal exited_tree(effect: Effect)
signal stack_changed(change: int)

var effect_instance: EffectInstance
var container: EffectComponent
var stacks: int = 0


func _add_stack() -> void:
	if stacks < effect_instance.max_stacks:
		stacks += 1
	stack_changed.emit(1)


func _remove_stack() -> void:
	stacks = max(0, stacks-1)
	stack_changed.emit(-1)
	if stacks == 0:
		exit_tree()

func _get_description() -> String:
	return ""

func exit_tree() -> void:
	exited_tree.emit(self)
