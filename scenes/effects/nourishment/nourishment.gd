extends Effect


@export var damage_per_speed: float = 1
@export var duration: float = 5.0
@onready var timer: Timer = $Timer
var active: bool = false
var current_attack_speed: float = 0

func _ready() -> void:
	container.projectile_component.entity_killed.connect(on_entity_killed)


func _process(delta: float) -> void:
	if not active or container.stats_component.attack_speed_mult <= 1:
		return
	
	if current_attack_speed != container.stats_component.attack_speed_mult:
		var diff = container.stats_component.attack_speed_mult - current_attack_speed
		container.stats_component.damage_mult += diff * damage_per_speed
		current_attack_speed += diff


func get_description() -> String:
	return "[b]Attack Damage[/b] per [b]Attack Speed[/b]: %s" % damage_per_speed + "%"


func clear_effect() -> void:
	if active:
		container.stats_component.damage_mult -= (current_attack_speed-1) * damage_per_speed


func on_entity_killed(hitbox: HitboxComponent, damage_datas: Array[DamageData]) -> void:
	active = true
	timer.start(duration)


func _on_timer_timeout() -> void:
	container.stats_component.damage_mult -= current_attack_speed * damage_per_speed
	current_attack_speed = 0
	active = false
