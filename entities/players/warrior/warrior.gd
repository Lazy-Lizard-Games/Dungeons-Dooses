extends Entity

@export var velocity_component: VelocityComponent
@export var hitbox_component: HitboxComponent


func _ready() -> void:
	if hitbox_component:
		hitbox_component.hit_by_damage.connect(on_hit_by_damage)


func _physics_process(_delta):
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity_component.accelerate_to_velocity(direction * velocity_component.max_speed)
	velocity_component.move(self)


func on_hit_by_damage(damage: DamageData, source: Entity) -> void:
	print("%s (%s): %s (%s)" % [source.id, source.faction, damage.amount, damage.type])
