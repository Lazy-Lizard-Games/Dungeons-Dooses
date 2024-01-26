extends EntityAction
class_name StackingEntityAction

signal stacks_changed

var stacks: int:
	set(new_stacks):
		stacks = new_stacks
		stacks_changed.emit()


func reverse(_entity: Entity) -> void:
	pass


func update_stacks(new_stacks: int) -> void:
	stacks = new_stacks
