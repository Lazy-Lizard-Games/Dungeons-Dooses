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

func execute(actor: Entity, target: Entity, scale:=1.0) -> void:
	var damage_affinity = actor.affinities.get_damage_affinity(damage_entity.type)
	var modifier = ConstantNumber.new()
	modifier.constant = 1
	if damage_affinity:
		modifier.constant = 1 + damage_affinity.get_final_value()
	var number = MultiplyNumber.new()
	number.x = damage_entity.amount
	number.y = modifier
	var temp_damage = damage_entity.duplicate(true)
	temp_damage.amount = number
	ticking_timer = Timer.new()
	ticking_timer.timeout.connect(damage.bind(target, temp_damage, scale))
	target.add_child(ticking_timer)
	ticking_timer.start(interval.execute())

func damage(entity: Entity, temp_damage: DamageEntityAction, scale:=1.0) -> void:
	if stacks <= 0:
		ticking_timer.start(interval.execute())
		return
	temp_damage.execute(entity, scale)
	ticking_timer.start(interval.execute() * (max_stacks / float(max_stacks + stacks * 2)))

func reverse(_actor: Entity, target: Entity) -> void:
	target.remove_child(ticking_timer)
