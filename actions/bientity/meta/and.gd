extends BientityAction
class_name AndBientityAction

## Executes an array of bientity actions on the pair.

## Bientity actions to execute.
@export var bientity_actions: Array[BientityAction]


func execute(actor: Entity, target: Entity, scale := 1.0) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	for action in bientity_actions:
		action.execute(actor, target, scale)
