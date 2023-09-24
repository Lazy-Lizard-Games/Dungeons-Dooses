extends Effect

@export var bloodlust_instance: EffectInstance
@export var stacks_per_point: int = 1

var bloodlust_effect = null


func _ready() -> void:
	bloodlust_effect = container.get_effect(bloodlust_instance)
	container.projectile_component.entity_killed.connect(on_entity_killed)


func _get_description() -> String:
	var effect = stacks_per_point*stacks
	var desc = "[b]Blood stacks on kill[/b]: +%s" % effect
	return desc


func on_entity_killed(hitbox: HitboxComponent, damage_datas) -> void:
	if bloodlust_effect:
		for i in range(stacks_per_point*stacks):
			bloodlust_effect.on_entity_damaged(hitbox, damage_datas)
