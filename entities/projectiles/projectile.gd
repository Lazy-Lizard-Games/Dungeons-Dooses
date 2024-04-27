class_name Projectile
extends Entity

## Describes the generic properties of a projectile.

@export var hurtbox_component: HurtboxComponent
@export var impact_data: ImpactData

func init(new_position: Vector2, new_direction: Vector2, new_impact_data: ImpactData) -> void:
	global_position = new_position
	impact_data = new_impact_data
	look_at(global_position + new_direction)