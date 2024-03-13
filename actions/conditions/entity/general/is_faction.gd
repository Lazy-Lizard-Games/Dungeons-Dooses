class_name IsFactionEntityCondition
extends EntityCondition

## Checks if the entity is a certain faction.

## Faction to check the entity against.
@export var faction: Enums.FactionType

func execute(entity: Entity) -> bool:
  return bool((int(entity.faction == faction) + int(invert)) % 2)
