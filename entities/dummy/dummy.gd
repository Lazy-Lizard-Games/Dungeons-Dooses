extends Entity

@export var health: HealthComponent
@export var hitbox: HitboxComponent
@export var hurtbox: HurtboxComponent


func _ready():
	hitbox.faction = faction
	hurtbox.faction = faction


func _on_health_component_damaged(damage_data: DamageData, source: HurtboxComponent) -> void:
	TextHandler.create_damage_text(damage_data, global_position)


func _on_health_component_died(damage_data: DamageData, source: HurtboxComponent) -> void:
	health.current_health = health.max_health.get_final_value()
