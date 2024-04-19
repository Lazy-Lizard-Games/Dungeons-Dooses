class_name HostileDummy
extends Mob

## Test dummy for hostile attacks (projectiles, damage, effects, etc.)

@export var ability: AbilityComponent

func _on_timer_timeout():
	ability.cast_ability(0, self)
