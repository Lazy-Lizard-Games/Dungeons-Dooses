extends Node


func add(projectile: Projectile) -> void:
	projectile.expired.connect(remove)
	add_child(projectile)
	projectile.enter()


func remove(projectile: Projectile) -> void:
	projectile.expired.disconnect(remove)
	remove_child(projectile)
	projectile.queue_free()
