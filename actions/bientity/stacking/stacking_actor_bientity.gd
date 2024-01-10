extends StackingBientityAction
class_name StackingActorBientityAction

@export var stacking_entity: StackingEntityAction


func execute(actor: Entity, target: Entity) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	stacking_entity.execute(actor)


func update_stacks(new_stacks: int) -> void:
	super(new_stacks)
	stacking_entity.update_stacks(new_stacks)
