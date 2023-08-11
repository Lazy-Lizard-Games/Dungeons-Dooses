extends CharacterBody2D
class_name Projectile

@export var velocity_component: VelocityComponent
@export var hurtbox_component: HurtboxComponent

var parent: ProjectileComponent
var direction: Vector2
var faction: Globals.FACTIONS:
	set(value):
		faction = value
		if hurtbox_component:
			hurtbox_component.faction = value
var damage_datas: Array[DamageData]:
	set(value):
		damage_datas = value
		if hurtbox_component:
			hurtbox_component.damage_datas = value
var effect_instances: Array[EffectInstance]:
	set(value):
		effect_instances = value
		if hurtbox_component:
			hurtbox_component.effect_instances = value
