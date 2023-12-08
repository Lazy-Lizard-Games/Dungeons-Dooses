extends Node2D
class_name Projectile

signal expired(projectile: Projectile)

var hurtbox_component: HurtboxComponent
var faction: Globals.FACTION
var direction: Vector2


func enter() -> void:
	pass

