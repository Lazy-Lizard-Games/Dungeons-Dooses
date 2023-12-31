extends Area2D
class_name HitboxComponent

signal hit(actor: Entity)

@export var entity: Entity
@export var detect_only := false
