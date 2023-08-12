extends Resource
class_name WeaponSkill

@export var skill_name: String
@export var skill_icon: Texture2D
@export_range(0, 2) var move_modifier: float = 1.0
@export var base_cooldown: float = 1.0
@export var damage_instances: Array[DamageInstance]
@export var effect_instances: Array[EffectInstance]
@export var projectile_scene: PackedScene
@export var down_animation: Animation
@export var left_animation: Animation
@export var right_animation: Animation
@export var up_animation: Animation

var on_cooldown: bool = false
var cooldown: float

func start_cooldown(root: Node, stats_component: StatsComponent = null) -> void:
	on_cooldown = true
	var timer = Timer.new()
	root.add_child(timer)
	timer.timeout.connect(func():
		on_cooldown = false
		root.remove_child(timer))
	cooldown = base_cooldown
	if stats_component:
		cooldown /= stats_component.attack_speed_mult
	timer.start(cooldown)
