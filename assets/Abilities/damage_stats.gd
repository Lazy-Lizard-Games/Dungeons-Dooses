extends Resource
class_name DamageStats

## Chance that an attack will deal bonus damage.
@export var crit_chance: float
## Damage multiplier for critical hits.
@export var crit_mult: float
## Damage modifiers for specific types of damage.
@export var damage_modifiers: Array[DamageModifier]
## Status effects applied by the attack.
@export var effects: Array[Effect]

func mod_stats(stats: DamageStats) -> void:
	crit_chance += stats.crit_chance
	crit_mult += stats.crit_mult
	for dm in stats.damage_modifiers:
		damage_modifiers.append(dm)
	for e in stats.effects:
		effects.append(e)
