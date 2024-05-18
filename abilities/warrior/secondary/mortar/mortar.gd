extends Ability

## Fire an explosive device at your enemies using a portable cannon. Dynamite comes in small packages, and big ones too.

const DAMAGE_TYPE = Enums.DamageType.Blunt

@export var player: Player
@export var idle_state: State
@export var animation_player: AnimationPlayer
@export var damage: float
@export var knockback: float
@export var effect: Effect
@export_range(0, 1) var chance: float
@export var projectile_scene: PackedScene

var is_casted := false
var has_fired := false

func enter() -> void:
	animation_player.play("mortar_load")
	cast()

func exit() -> void:
	is_casted = false
	has_fired = false
	refresh()

func process_frame(delta: float) -> State:
	# animation_player.is_playing()
	var current_position = animation_player.current_animation_position
	if has_fired and current_position >= animation_player.current_animation_length:
		return idle_state
	if state == AbilityState.Casting and !is_casted:
		casting_timer += delta * player.stats_component.charge_rate.get_final_value()
		if casting_timer >= casting_time:
			is_casted = true
			animation_player.play("mortar_idle")
			casted.emit()
	if Input.is_action_just_released("ability_2"):
		if is_casted:
			if !has_fired:
				fire()
		else:
			return idle_state
	return null

func get_target_position() -> Vector2:
	return player.get_global_mouse_position()

func fire() -> void:
	has_fired = true
	animation_player.play("mortar_fire")
	player.stamina_component.exhaust(cost * player.stats_component.ability_efficiency.get_final_value())
	player.get_tree().create_timer(0.25).timeout.connect(_on_timeout)

func _on_timeout() -> void:
	var affinity = player.stats_component.get_damage_affinity(DAMAGE_TYPE).get_final_value()
	var damage_data = DamageData.new(damage * affinity, DAMAGE_TYPE)
	var effect_data = EffectData.new(effect, chance)
	var impact_data = ImpactData.new([damage_data], knockback, [effect_data])
	var target_position = get_target_position()
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.init(target_position, player.looking_at, impact_data, player.faction, false)
	ProjectileHandler.add_projectile(projectile)

func _on_refreshed():
	ready()
