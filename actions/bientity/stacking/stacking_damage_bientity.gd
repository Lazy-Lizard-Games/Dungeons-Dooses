extends StackingBientityAction
class_name StackingDamageBientity

## Deals damage at regular intervals while the stacking resource is active.

## Damage to be dealt to the entity per stack per tick.
@export var damage_bientity: DamageBientityAction
## Interval in seconds between damaging the entity.
@export var interval: NumberProvider

var ticking_timer: Timer

func execute(actor: Entity, target: Entity) -> void:
	ticking_timer = Timer.new()
	ticking_timer.timeout.connect(
		func():
			if stacks <= 0:
				ticking_timer.start(interval.execute())
				return
			damage_bientity.execute(actor, target)
			ticking_timer.start(interval.execute() * ((max_stacks - stacks)/float(max_stacks)))
	)
	target.add_child(ticking_timer)
	ticking_timer.start(interval.execute())


func reverse(_actor: Entity, target: Entity) -> void:
	target.remove_child(ticking_timer)

