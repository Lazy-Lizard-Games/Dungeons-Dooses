extends Node2D
class_name Projectile

var damage_data: DamageData
var hit_bodies = []

func load_damage(damage: DamageData) -> void:
	damage_data = damage

func _ready() -> void:
	start()

func start() -> void:
	print("Projectile Spawned")
	print("Killing Projectile")
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body not in hit_bodies:
		hit_bodies.append(body)
		hit_bodies.damage(damage_data)

