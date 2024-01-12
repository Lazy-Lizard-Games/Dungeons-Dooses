extends StackingBientityAction
class_name StackingTargetBientityAction

@export var stacking_entity: StackingEntityAction


func execute(actor: Entity, target: Entity) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	stacking_entity.execute(target)


func update_stacks(new_stacks: int) -> void:
	super(new_stacks)
	stacking_entity.update_stacks(new_stacks)


func reverse(_actor: Entity, target: Entity) -> void:
	stacking_entity.reverse(target)
