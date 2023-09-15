extends Effect

@export var blood_instance: EffectInstance
@export var blood_gain_bonus: float = 0


func _ready() -> void:
	container.projectile_component.entity_damaged.connect(on_entity_damaged)


func on_entity_damaged(hitbox: HitboxComponent, damage_datas: Array[DamageData]) -> void:
	container.add_effect(blood_instance)

