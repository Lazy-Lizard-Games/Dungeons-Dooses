extends Resource
class_name Skill

@export var name: String
@export_multiline var description: String
@export var max_stacks: int
@export var actions_per_stack: Array[StackingBientityAction]
var current_stacks = 0


## Attempts to purchase an amount of stacks in the skill and returns the result.
func purchase(entity: Entity) -> bool:
	if current_stacks >= max_stacks:
		return false
	current_stacks += 1
	## Create stacking resource from provided parameters.
	var stacking_resource = StackingBientityResource.new()
	stacking_resource.name = name
	stacking_resource.description = description
	stacking_resource.actions_per_stack = actions_per_stack
	stacking_resource.max_stacks = max_stacks
	stacking_resource.starting_stacks = 1
	## Create action to add stacking resource.
	var add_bientity_resource = AddBientityResourceAction.new()
	add_bientity_resource.resource = stacking_resource
	## Number of stacks to add.
	var number = ConstantNumber.new()
	number.constant = 1
	add_bientity_resource.number = number
	## Add resource.
	add_bientity_resource.execute(entity, entity) 
	return true


## Resets current stack to zero and removes the stacking resource from the entity.
func refund(entity: Entity) -> void:
	current_stacks = 0
	var revoke_resource = RevokeBientityResourceAction.new()
	revoke_resource.name = name
	revoke_resource.execute(entity, entity)
