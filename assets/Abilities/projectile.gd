extends Node2D
class_name Projectile

var damage_data = DamageData.new()
var hit_bodies = []

func mod_stats(stats: DamageStats) -> void:
	damage_data.mod_stats(stats)

func mod_damage_data(data: DamageData) -> void:
	damage_data.mod_data(data)

func _ready() -> void:
	start()

func start() -> void:
	print("Projectile Spawned")
	print("Killing Projectile")
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body not in hit_bodies:
		hit_bodies.append(body)
		body.damage(damage_data)

