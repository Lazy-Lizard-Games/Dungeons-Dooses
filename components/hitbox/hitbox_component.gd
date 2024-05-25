extends Area2D
class_name HitboxComponent

## Triggered when the hitbox component handles impact from a hurtbox.
signal impacted(data: ImpactData, from: HurtboxComponent, immunity: bool)

## The health component that will handle damages taken.
@export var health_component: HealthComponent
## The velocity component that will handle knockback applied.
@export var velocity_component: VelocityComponent
## The effect component that will handle effects applied.
@export var effect_component: EffectComponent
## The stats component that will handle value transformations.
@export var stats_component: StatsComponent
## The faction which the hitbox belongs to.
@export var faction: Enums.FactionType
## Toggles whether hitbox can handle impact events.
@export var detect_only := false
## Duration of invulnerability after being hit, 0 if none.
@export var invulnerability_duration: float
var invulnerability_timer: Timer
var is_immune = false

func handle_impact(data: ImpactData, from: HurtboxComponent) -> void:
	if !is_immune:
		handle_damages(data.damages, from)
		handle_knockback(data.knockback, from)
		handle_effects(data.effects, from)
		detect_only = true
		invulnerability_timer.start(invulnerability_duration)
	impacted.emit(data, from, is_immune)

func handle_damages(damage_datas: Array[DamageData], from: HurtboxComponent) -> void:
		if health_component:
			for damage_data in damage_datas:
				var outcome = health_component.damage_with_transforms(damage_data)
				if outcome.final_health_state == health_component.HealthState.Dead:
					from.death_dealt.emit(damage_data, self)
				else:
					from.damage_dealt.emit(damage_data, self)

func handle_knockback(knockback: float, from: HurtboxComponent) -> void:
	if velocity_component:
		var final_knockback = apply_knockback_transforms(knockback)
		velocity_component.knockback(final_knockback, from.global_position.direction_to(global_position))
		from.knockback_applied.emit(knockback, self)

func apply_knockback_transforms(strength: float) -> float:
	if stats_component:
		return strength * (1 - stats_component.knockback_resistance.get_final_value())
	return strength

func handle_effects(effect_datas: Array[EffectData], from: HurtboxComponent) -> void:
	if effect_component:
		for effect_data in effect_datas:
			if randf() <= effect_data.chance:
				var duplicated_effect = effect_data.effect.duplicate(true)
				effect_component.add_effect(duplicated_effect, effect_data.stacks)
				from.effect_applied.emit(duplicated_effect, self)

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
