extends Mob
class_name Dummy



func _on_hitbox_component_hit(actor: Entity) -> void:
	render_component.play('hit')
	render_component.animation_finished.connect(
		func():
			render_component.play('idle')
	)
