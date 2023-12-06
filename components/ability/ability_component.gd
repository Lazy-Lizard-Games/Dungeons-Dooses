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
@export
var temp_abilities: Array[Ability]
## References the currently active ability.
var active_ability : Ability = null
var active_index : float = -1


## Assigns the ability to the given index.
func set_ability(index: int, ability_data: AbilityData) -> void:
	pass


## Starts the ability at the given index.
func start(index: int, direction: Vector2) -> Ability:
	var ability = temp_abilities[index]
	if !ability or ability.current_state != ability.state.READY:
		return null
	ability.init(self, direction)
	ability.start()
	return ability


## Releases charged abilities or stops auto-fire abilities.
func release(index: int) -> void:
	if !temp_abilities[index]:
		return
	temp_abilities[index].release()


## Used to stop an ability prematurely.
func cancel(index: int) -> void:
	if !temp_abilities[index]:
		return
	temp_abilities[index].cancel()
