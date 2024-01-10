extends StackingEntityAction
class_name StackingTickingDamage

## Deals damage at regular intervals while the stacking resource is active.

## Damage to be dealt to the entity per stack per tick.
@export var damage_entity: DamageEntityAction
## Interval in seconds between damaging the entity.
@export var interval: NumberProvider

var ticking_timer: Timer

func execute(entity: Entity) -> void:
	ticking_timer = Timer.new()
	ticking_timer.timeout.connect(
		func():
			if stacks <= 0:
				ticking_timer.start(interval.execute())
				return
			damage_entity.execute(entity)
			ticking_timer.start(interval.execute()/stacks)
	)
	entity.add_child(ticking_timer)
	ticking_timer.start(interval.execute())


func reverse(entity: Entity) -> void:
	entity.remove_child(ticking_timer)


func update_stacks(new_stacks: int) -> void:
	super(new_stacks)
