extends Resource
class_name WeaponSkill

@export_range(0, 2) var move_modifier: float = 1.0
@export var projectile: PackedScene
@export var down_animation: Animation
@export var left_animation: Animation
@export var right_animation: Animation
@export var up_animation: Animation