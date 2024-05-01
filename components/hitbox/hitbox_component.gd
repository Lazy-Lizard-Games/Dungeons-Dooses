extends Area2D
class_name HitboxComponent

## Perhaps deprecated...
signal impacted(from: HurtboxComponent)

## The health component that will handle damages taken.
@export var health_component: HealthComponent
## The velocity component that will handle knockback applied.
@export var velocity_component: VelocityComponent
## The effect component that will handle effects applied.
@export var effect_component: EffectComponent
## The stats component that will handle value transformations.
@export var stats_component: StatsComponent

## Toggles whether hitbox can handle impact events.
@export var detect_only := false
## Duration of invulnerability after being hit, 0 if none.
@export var invulnerability_duration: float
var invulnerability_timer: Timer

func handle_impact(data: ImpactData, from: HurtboxComponent) -> void:
	handle_damages(data.damages, from)
	handle_knockback(data.knockback, from)
	handle_effects(data.effects, from)
	detect_only = true
	invulnerability_timer.start(invulnerability_duration)
	impacted.emit(from)

func handle_damages(damages: Array[DamageData], from: HurtboxComponent) -> void:
		if health_component:
			var final_damages = apply_damage_transforms(damages)
			for d in final_damages:
				var state = health_component.damage(d.amount, d.type)
				if state == health_component.HealthState.Dead:
					from.death_dealt.emit(d.amount, d.type, self)
				else:
					from.damage_dealt.emit(d.amount, d.type, self)

func apply_damage_transforms(damages: Array[DamageData]) -> Array[DamageData]:
	if stats_component:
		var transformed_damages: Array[DamageData] = []
		for d in damages:
			var resistance = stats_component.get_damage_resistance(d.type)
			var transformed_damage = DamageData.new(d.amount * (1 - resistance.get_final_value()), d.type)
			transformed_damages.append(transformed_damage)
		return transformed_damages
	return damages

func handle_knockback(knockback: float, from: HurtboxComponent) -> void:
	if velocity_component:
		var final_knockback = apply_knockback_transforms(knockback)
		velocity_component.knockback(final_knockback, from.global_position.direction_to(global_position))
		from.knockback_applied.emit(knockback, self)

func apply_knockback_transforms(strength: float) -> float:
	if stats_component:
		return strength * (1 - stats_component.knockback_resistance.get_final_value())
	return strength

func handle_effects(effects: Array[Effect], from: HurtboxComponent) -> void:
	if effect_component:
		for effect in effects:
			effect_component.add_effect(effect)
			from.effect_applied.emit(effect, self)

func _ready():
	invulnerability_timer = Timer.new()
	invulnerability_timer.timeout.connect(_on_invulnerability_timer_timeout)
	add_child(invulnerability_timer)

func _on_invulnerability_timer_timeout() -> void:
	detect_only = false
	monitoring = true
	for area in get_overlapping_areas():
		if area is HurtboxComponent:
			area.on_area_collision(self)
			monitoring = false
			break
	monitoring = false