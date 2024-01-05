extends Mob


func _on_hitbox_component_hit(actor: Entity) -> void:
	print("Hit by: ", actor.id)
