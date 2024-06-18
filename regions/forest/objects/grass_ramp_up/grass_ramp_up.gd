extends Node2D


## The elevation the ramp leads up to.
@export var up_to: int
## The elevation the ramp leads down to.
@export var down_to: int

@onready var ramp_walls_up: StaticBody2D = $Offset/RampWallsUp
@onready var ramp_walls_down: StaticBody2D = $Offset/RampWallsDown
@onready var area_up_to: Area2D = $Offset/AreaUpTo
@onready var area_down_to: Area2D = $Offset/AreaDownTo

func _ready():
	ramp_walls_up.set_collision_layer_value(9 + down_to, true)
	ramp_walls_down.set_collision_layer_value(9 + up_to, true)
	area_up_to.set_collision_mask_value(9 + down_to, true)
	area_down_to.set_collision_mask_value(9 + up_to, true)

func _on_area_up_to_body_entered(body:Node2D) -> void:
	if body is Entity:
		body.set_elevation(up_to)

func _on_area_down_to_body_entered(body:Node2D) -> void:
	if body is Entity:
		body.set_elevation(down_to)
