extends Node2D
class_name AbilityComponent

## Handles active damage calls, like casting a fireball or swinging a sword.

signal entity_damaged(damage: DamageData, target: Entity)
signal entity_killed(damage: DamageData, target: Entity)

## References the stats component for manipulation by the activated ability.
@export
var stats: StatsComponent
## Stores the available abilities for the entity to use.
@export
var abilities : Array[AbilityData]
## References the currently active ability.
var active_ability : Ability = null
var active_index : float = -1

## Activates an ability if none it exists and is not already casting.
func start(index: int, direction: Vector2) -> Ability:
	if active_ability != null:
		print("WeaponComponent: Ability already active.")
		return
	
	if abilities.size() < index or not abilities[index]:
		print("WeaponComponent: Ability does not exist.")
		return
	
	var ability = abilities[index]
	active_index = index
	active_ability = abilities[index].ability.instantiate() as Ability
	active_ability.expired.connect(on_ability_expired)
	active_ability.init(self, direction)
	add_child(active_ability)
	active_ability.start()
	return active_ability


## Releases charged abilities or stops auto-fire abilities.
func release(index: int) -> void:
	if !active_ability or index != active_index:
		return
	active_ability.release()


## Stops charged abilities, returning any cooldown.
func cancel() -> void:
	if !active_ability:
		return
	active_ability.cancel()


## Clean up the ability when it is finished.
func on_ability_expired() -> void:
	remove_child(active_ability)
	active_ability.queue_free()
	active_ability = null
	active_index = -1
