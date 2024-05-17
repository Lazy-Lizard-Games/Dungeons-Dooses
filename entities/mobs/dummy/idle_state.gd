extends State

@export var animation_tree: AnimationTree

func _on_hitbox_component_impacted(_from: HurtboxComponent):
	animation_tree['parameters/playback'].travel('hit')

