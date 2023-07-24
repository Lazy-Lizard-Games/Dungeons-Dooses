extends Resource
class_name DamageStats

@export var crit_chance: float
@export var crit_mult: float
@export var damage_modifiers: Array[DamageModifier]
@export var effects: Array[Effect]

func mod_stats(stats: DamageStats) -> void:
	crit_chance += stats.crit_chance
	crit_mult += stats.crit_mult
	for dm in stats.damage_modifiers:
		damage_modifiers.append(dm)
	for e in stats.effects:
		effects.append(e)
