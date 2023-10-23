extends Effect


@export var blood_instance: EffectInstance
@export var extra_stack_chance: float = 0.1


func _ready() -> void:
	container.projectile_component.entity_damaged.connect(on_entity_damaged)


func on_entity_damaged(hitbox: HitboxComponent, damage_datas: Array[DamageData]) -> void:
	if randf_range(0, 1) < (extra_stack_chance * stacks):
		container.add_effect(blood_instance)


func _get_description() -> String:
	var effect = extra_stack_chance * stacks * 100
	var description = "[b]Extra chance[/b]: +%s" % effect
	return description + "%"
