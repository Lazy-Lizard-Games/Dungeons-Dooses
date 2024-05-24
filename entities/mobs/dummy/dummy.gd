class_name Dummy
extends Mob

## It's a dummy, dummy!

@export var indicator_spawn_point: Marker2D
var damage_indicator_scene = preload ("res://features/damage/ui/damage_indicator.tscn")

func _on_health_component_damaged(damage_data: DamageData) -> void:
	# Create a damage indicator
	var damage_indicator: DamageIndicator = damage_indicator_scene.instantiate()
	damage_indicator.load_damage_data(damage_data)
	damage_indicator.position = indicator_spawn_point.position
	add_child(damage_indicator)