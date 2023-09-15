extends Effect

@export var blood_instance: EffectInstance
@export var health_per_point: float = 0.005

var blood_effect: Effect


func _ready():
	container.projectile_component.entity_killed.connect(on_entity_killed)


func _process(delta):
	if blood_effect:
		return
	blood_effect = container.get_effect(blood_instance)
	if blood_effect:
		blood_effect.exited_tree.connect(on_blood_stack_exited)


func _get_description() -> String:
	var effect = health_per_point*stacks*100
	var desc = "[b]Max Health Leech[/b]: +%s" % effect
	return desc+"%"


func on_entity_killed(hitbox: HitboxComponent, damage_datas) -> void:
	if blood_effect:
		var leeched_health = hitbox.health_component.max_health * health_per_point * stacks * blood_effect.stacks
		container.health_component.heal(leeched_health)


func on_blood_stack_exited(effect: Effect) -> void:
	blood_effect = null

