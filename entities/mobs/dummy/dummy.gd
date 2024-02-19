extends Mob
class_name Dummy



func _on_hitbox_component_hit(actor: Entity) -> void:
	animation_tree['parameters/playback'].travel('hit')
