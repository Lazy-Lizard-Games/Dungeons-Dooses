extends Mob

@export var animation_tree: AnimationTree

func _on_hitbox_component_hit(_actor: Entity) -> void:
	animation_tree['parameters/playback'].travel('hit')
