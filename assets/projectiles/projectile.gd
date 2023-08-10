extends CharacterBody2D
class_name Projectile

@export var velocity_component: VelocityComponent
@export var hurtbox_component: HurtboxComponent

var direction: Vector2
var faction: Globals.FACTIONS:
	set(value):
		faction = value
		hurtbox_component.faction = value

func set_damage_datas(damage_datas: Array[DamageData]) -> void:
	hurtbox_component.damage_datas = damage_datas

func set_direction(dir: Vector2) -> void:
	direction = dir
