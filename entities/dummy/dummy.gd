extends Entity

@export var health: HealthComponent
@export var hitbox: HitboxComponent
@export var hurtbox: HurtboxComponent


func _ready():
	hitbox.faction = faction
	hurtbox.faction = faction
