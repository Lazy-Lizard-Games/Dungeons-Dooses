extends StackingBientityAction
class_name StackingActorBientityAction

@export var stacking_entity: StackingEntityAction


func execute(actor: Entity, target: Entity, scale := 1.0) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	stacking_entity.execute(actor, scale)


func update_stacks(new_stacks: int) -> void:
	super(new_stacks)
	stacking_entity.update_stacks(new_stacks)


func reverse(actor: Entity, _target: Entity) -> void:
	stacking_entity.reverse(actor)
