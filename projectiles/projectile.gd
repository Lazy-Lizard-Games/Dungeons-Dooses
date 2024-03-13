class_name Projectile
extends CharacterBody2D

## Describes the generic properties of a projectile.

var direction: Vector2
var entity: Entity

func init(entity_in: Entity, position_in: Vector2, direction_in: Vector2) -> void:
  entity = entity_in
  position = position_in
  direction = direction_in
  look_at(position + direction)