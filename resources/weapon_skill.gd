extends Resource
class_name WeaponSkill

@export_range(0, 2) var move_modifier: float = 1.0
@export_range(0, 2) var damage_modifier: float = 1.0
@export var projectile: Projectile
@export var down_animation: Animation
@export var left_animation: Animation
@export var right_animation: Animation
@export var up_animation: Animation

func transform_damage_data(damage_data: DamageData) -> DamageData:
	var final_damage = damage_data.copy()
	final_damage.damage *= damage_modifier
	return final_damage
