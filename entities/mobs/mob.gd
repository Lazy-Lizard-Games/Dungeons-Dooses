class_name Mob
extends Entity

## Mobs are for entities that can take damage and be manipulated.

## Hitbox component for the mob.
@export var hitbox_component: HitboxComponent
## Health component for the mob.
@export var health_component: HealthComponent
## Stamina component for the mob.
@export var stamina_component: StaminaComponent
## Ability component for the mob.
@export var ability_component: AbilityComponent
## Effect component for the mob.
@export var effect_component: EffectComponent
## Generic attributes for the mob.
@export var stats_component: StatsComponent
## State component for the mob.
@export var state_component: StateComponent
