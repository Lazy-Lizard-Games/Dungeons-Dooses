extends Resource
class_name ChargeLevel

## Cost in stamina of the ability.
@export var cost: Number
## Minimum charge level as a percentage to meet requirement.
@export_range(0, 1) var minimum_charge: float
## Actions to cast if requirement met.
@export var actions_on_cast: Array[EntityAction]
