extends Projectile


func _on_hurtbox_component_hurt(hitbox: HitboxComponent):
	if not hitbox.entity:
		return
