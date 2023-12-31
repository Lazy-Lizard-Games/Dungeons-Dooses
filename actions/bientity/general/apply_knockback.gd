extends BientityAction
class_name ApplyKnockbackAction

## Applies knockback on the target entity based on the position of the actor.

## Max speed for knockback.
@export var speed: float
## Duration of knockback's control modifier.
@export var duration: float
## Attribute modifier to modify entity control during knockback.
@export var control_modifier: AttributeModifier

var add_velocity = AddVelocityAction.new()
var modify_control = ModifyControl.new()
var timed_action = TimedEntityAction.new()


func execute(actor: Entity, target: Entity) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	var direction = actor.global_position.direction_to(target.global_position)
	
	## Starts the timed modify control action .
	modify_control.modifier = control_modifier
	timed_action.modify_action = modify_control
	timed_action.duration = duration
	timed_action.execute(target)
	
	## Adds the velocity to the entity.
	add_velocity.direction = direction
	add_velocity.speed = speed
	add_velocity.execute(target)
