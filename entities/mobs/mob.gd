extends Entity
class_name Mob

## Mobs are for entities that can take damage and be manipulated.

## Hitbox component for the entity.
@export var hitbox_component: HitboxComponent
## Health component for the entity.
@export var health_component: HealthComponent
## Effect component for the entity.
@export var effect_component: EffectComponent
## Generic attributes for the entity.
@export var stats_component: StatsComponent
