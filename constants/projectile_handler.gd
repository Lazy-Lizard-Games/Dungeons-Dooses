extends Node

var projectiles: Array[BaseProjectile]
var traps: Array[Trap]
var main: Main


func _ready():
	for child in get_tree().root.get_children():
		if child.name == 'Main':
			main = child
			break 


func add_trap(trap: Trap) -> void:
	traps.append(trap)
	main.entities.add_child(trap)


func remove_trap(trap: Trap) -> void:
	if trap in traps:
		traps.erase(trap)
	trap.queue_free()


func add_projectile(projectile: BaseProjectile) -> void:
	projectiles.append(projectile)
	main.projectiles.add_child(projectile)


func remove_projectile(projectile: BaseProjectile) -> void:
	if projectile in projectiles:
		projectiles.erase(projectile)
	projectile.queue_free()
