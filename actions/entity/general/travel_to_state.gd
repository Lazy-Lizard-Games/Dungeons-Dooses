extends EntityAction
class_name TravelToStateEntityAction

## Travels to the state found at the path of the entities animation tree.

## Path to the animation tree state.
@export var path: String

func execute(entity: Entity, _scale:=1.0) -> void:
	entity.animation_tree['parameters/playback'].travel(path)
