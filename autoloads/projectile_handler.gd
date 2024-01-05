extends Node

var projectiles: Array[Projectile]


func add(projectile: Projectile) -> void:
	projectiles.append(projectile)
	add_child(projectile)


func remove(projectile: Projectile) -> void:
	if projectile in projectiles:
		projectiles.erase(projectile)
	projectile.queue_free()
