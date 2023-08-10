extends Node2D
class_name WeaponComponent

@export var move_modifier: float
@export var projectile_component: ProjectileComponent
@export_group("Weapon Skills")
@export var weapon_skills: Array[WeaponSkill]
@export_group("Animation Node Resources")
@export var attack_up_res: AnimationNodeAnimation
@export var attack_down_res: AnimationNodeAnimation
@export var attack_left_res: AnimationNodeAnimation
@export var attack_right_res: AnimationNodeAnimation

func attack(skill_index: int) -> bool:
	if skill_index < weapon_skills.size():
		var skill = weapon_skills[skill_index]
		if skill != null:
			set_weapon_skill(skill)
			return true
	return false

func set_weapon_skill(skill: WeaponSkill) -> void:
	if typeof(skill) == TYPE_NIL:
		return
	set_attack_animations(skill)
	set_projectile(skill.projectile)
	set_move_modifier(skill.move_modifier)

func set_attack_animations(skill: WeaponSkill) -> void:
	attack_up_res.animation = skill.up_animation.resource_name
	attack_down_res.animation = skill.down_animation.resource_name
	attack_left_res.animation = skill.left_animation.resource_name
	attack_right_res.animation = skill.right_animation.resource_name

func set_projectile(projectile: PackedScene) -> void:
	if projectile_component == null:
		return
	projectile_component.projectile = projectile

func set_move_modifier(modifier: float) -> void:
	move_modifier = modifier

func spawn_projectile(direction: Vector2) -> void:
	projectile_component.spawn_projectile(direction)
