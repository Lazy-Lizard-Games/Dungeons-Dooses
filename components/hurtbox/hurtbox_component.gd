extends Area2D
class_name HurtboxComponent

## Emitted when damage has caused a health component to die.
signal death_dealt(amount: float, type: Enums.DamageType, to: HitboxComponent)
## Emitted when damage has just done damage to a health component.
signal damage_dealt(amount: float, type: Enums.DamageType, to: HitboxComponent)
## Emiited when knockback has been applied to a velocity component.
signal knockback_applied(strength: float, to: HitboxComponent)
## Emitted when an effect as been added to an entity component.
signal effect_applied(effect: Effect, to: HitboxComponent)
## Mayhaps deprecated...
signal hurt(hitbox: HitboxComponent)

## Data to transfer on impact with a hitbox.
@export var impact_data: ImpactData
## Faction that the hurtbox belongs to.
@export var faction: Enums.FactionType
## Toggles whether the hurtbox hits allies or enemis of the faction.
@export var target_allies: bool

## Collection of already hit targets.
var hit_targets: Array[HitboxComponent] = []

func on_area_collision(area: Area2D) -> void:
	if area is HitboxComponent:
		if (target_allies and faction == area.faction) or (!target_allies and (faction != area.faction or area.faction == Enums.FactionType.None or faction == Enums.FactionType.None)):
			if area.detect_only:
				return
			if area in hit_targets:
				return
			hit_targets.append(area)
			var duplicated_impact_data = impact_data.duplicate(true) as ImpactData
			area.handle_impact(duplicated_impact_data, self)

func force_check() -> void:
	for area in get_overlapping_areas():
		on_area_collision(area)