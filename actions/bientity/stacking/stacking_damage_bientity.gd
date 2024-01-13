extends StackingBientityAction
class_name StackingDamageBientity

## Deals damage at regular intervals while the stacking resource is active.

## Damage to be dealt to the entity per stack per tick.
@export var damage_bientity: DamageBientityAction
## Interval in seconds between damaging the entity.
@export var interval: NumberProvider

var ticking_timer: Timer
var actor_copy: Entity
var target_copy: Entity


func execute(actor: Entity, target: Entity) -> void:
	actor_copy = actor.get_copy()
	target_copy = target.get_copy()
	ticking_timer = Timer.new()
	ticking_timer.timeout.connect(damage.bind(actor, target))
	target.add_child(ticking_timer)
	ticking_timer.start(interval.execute())


func damage(actor, target) -> void:
	if stacks <= 0:
		ticking_timer.start(interval.execute())
		return
	var a = actor as Entity if is_instance_valid(actor) else actor_copy
	var t = target as Entity if is_instance_valid(target) else target_copy
	damage_bientity.execute(a, t)
	ticking_timer.start(interval.execute() * ((max_stacks - (stacks - 1))/float(max_stacks)))


func reverse(_actor: Entity, target: Entity) -> void:
	target.remove_child(ticking_timer)

