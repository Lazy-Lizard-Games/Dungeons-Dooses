extends Effect


@export var bloodlust_instance: EffectInstance
@export var bonus_chance_per_point: float = 0.05

var bloodlust_effect = null


func _ready() -> void:
	bloodlust_effect = container.get_effect(bloodlust_instance)
	container.projectile_component.entity_damaged.connect(on_entity_damaged)


func _get_description() -> String:
	var effect = bonus_chance_per_point*stacks*100
	var desc = "[b]Bonus Chance[/b]: +%s" % effect
	return desc+"%"


func on_entity_damaged(hitbox: HitboxComponent, damage_datas: Array[DamageData]) -> void:
	if randf() < bonus_chance_per_point*stacks:
		bloodlust_effect.on_entity_damaged(hitbox, damage_datas)

