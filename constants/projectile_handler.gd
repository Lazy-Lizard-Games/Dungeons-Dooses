extends Node

var projectiles: Array[BaseProjectile]


func add(projectile: BaseProjectile) -> void:
	projectiles.append(projectile)
	add_child(projectile)


func remove(projectile: BaseProjectile) -> void:
	if projectile in projectiles:
		projectiles.erase(projectile)
	projectile.queue_free()
