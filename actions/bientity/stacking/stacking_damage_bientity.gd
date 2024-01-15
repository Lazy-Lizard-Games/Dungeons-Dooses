extends StackingBientityAction
class_name StackingDamageBientity

## Deals damage at regular intervals while the stacking resource is active.

## Damage to be dealt to the entity per stack per tick.
@export var damage_entity: DamageEntityAction
## Interval in seconds between damaging the entity.
@export var interval: Number

var ticking_timer: Timer
var actor_copy: Entity
var target_copy: Entity


func execute(actor: Entity, target: Entity) -> void:
	var damage_affinity = actor.affinities.get_damage_affinity(damage_entity.type)
	var modifier = ConstantProvider.new(1)
	if damage_affinity:
		modifier.number = 1 + damage_affinity.get_final_value()
	var multiplier = MultiplicationOperator.new(damage_entity.amount, modifier)
	damage_entity.amount = multiplier
	ticking_timer = Timer.new()
	ticking_timer.timeout.connect(damage.bind(target))
	target.add_child(ticking_timer)
	ticking_timer.start(interval.execute())


func damage(entity: Entity) -> void:
	if stacks <= 0:
		ticking_timer.start(interval.execute())
		return
	damage_entity.execute(entity)
	ticking_timer.start(interval.execute() * ((max_stacks - (stacks - 1))/float(max_stacks)))


func reverse(_actor: Entity, target: Entity) -> void:
	target.remove_child(ticking_timer)

