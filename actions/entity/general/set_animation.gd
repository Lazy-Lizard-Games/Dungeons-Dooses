extends EntityAction
class_name SetAnimationEntityAction

## Sets the current animation to an animation with the matching name. 
## Does nothing if the animation does not exist.

## Name of the animation to change to.
@export var animation: StringName


func execute(entity: Entity, _scale := 1.0) -> void:
	entity.render_component.update_animation(animation)
