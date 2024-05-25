class_name Projectile
extends Entity

## Describes the generic properties of a projectile.

@export var hurtbox_component: HurtboxComponent

func init(new_position: Vector2, new_direction: Vector2, new_impact_data: ImpactData, new_faction:=Enums.FactionType.None, target_allies:=false) -> void:
	global_position = new_position
	look_at(global_position + new_direction)
	hurtbox_component.impact_data = new_impact_data
	hurtbox_component.faction = new_faction
	hurtbox_component.target_allies = target_allies
	
