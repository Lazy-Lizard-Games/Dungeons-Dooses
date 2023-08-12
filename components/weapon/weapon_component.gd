extends Node2D
class_name WeaponComponent

signal skill_casted(skill: WeaponSkill)

@export var base_damage: float = 10
@export var move_modifier: float = 1
@export var damage_instances: Array[DamageInstance]
@export var effect_instances: Array[EffectInstance]
@export var projectile_component: ProjectileComponent
@export_group("Weapon Skills")
@export var weapon_skills: Array[WeaponSkill]
@export_group("Animation Node Resources")
@export var attack_up_res: AnimationNodeAnimation
@export var attack_down_res: AnimationNodeAnimation
@export var attack_left_res: AnimationNodeAnimation
@export var attack_right_res: AnimationNodeAnimation

var damage_datas: Array[DamageData]
var effect_datas: Array[EffectInstance]

func attack(skill_index: int) -> bool:
	if skill_index < weapon_skills.size():
		var skill = weapon_skills[skill_index]
		if skill != null and not skill.on_cooldown:
			set_weapon_skill(skill)
			return true
	return false

func set_weapon_skill(skill: WeaponSkill) -> void:
	if typeof(skill) == TYPE_NIL:
		return
	set_skill_cooldown(skill)
	set_attack_animations(skill)
	set_projectile(skill.projectile_scene)
	set_move_modifier(skill.move_modifier)
	set_damage_data(skill.damage_instances)
	set_effect_data(skill.effect_instances)
	skill_casted.emit(skill)

func set_skill_cooldown(skill: WeaponSkill) -> void:
	skill.start_cooldown(get_tree().root, get_parent().stats_component)

func set_attack_animations(skill: WeaponSkill) -> void:
	attack_up_res.animation = skill.up_animation.resource_name
	attack_down_res.animation = skill.down_animation.resource_name
	attack_left_res.animation = skill.left_animation.resource_name
	attack_right_res.animation = skill.right_animation.resource_name

func set_projectile(projectile_scene: PackedScene) -> void:
	if projectile_component == null:
		return
	projectile_component.projectile_scene = projectile_scene.duplicate()

func set_move_modifier(modifier: float) -> void:
	move_modifier = modifier

func set_damage_data(instances: Array[DamageInstance]) -> void:
	var total_instances = damage_instances.duplicate()
	total_instances.append_array(instances)
	damage_datas.clear()
	for instance in total_instances:
		damage_datas.append(instance.get_damage_data(base_damage))

func set_effect_data(instances: Array[EffectInstance]) -> void:
	effect_datas = effect_instances.duplicate()
	effect_datas.append_array(instances)

func spawn_projectile(direction: Vector2, faction: Globals.FACTIONS) -> void:
	if projectile_component.projectile_scene:
		projectile_component.spawn_projectile(damage_datas, effect_datas, direction, faction)
