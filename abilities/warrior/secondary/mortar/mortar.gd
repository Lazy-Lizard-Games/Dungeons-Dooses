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

var has_charged := false
var has_fired := false
var target := Vector2.ZERO

func enter() -> void:
	animation_player.play("mortar_load")
	cast()

func exit() -> void:
	has_charged = false
	has_fired = false
	refresh()

func process_frame(_delta: float) -> State:
	var current_position = animation_player.current_animation_position
	if has_fired and current_position >= animation_player.current_animation_length:
		return idle_state
	if Input.is_action_just_released("ability_2"):
		if has_charged:
			if !has_fired:
				fire()
		else:
			return idle_state
	return null

func get_target_position() -> Vector2:
	return player.get_global_mouse_position()

func fire() -> void:
	has_fired = true
	target = get_target_position()
	animation_player.play("mortar_fire")
	player.stamina_component.exhaust(cost * player.stats_component.ability_efficiency.get_final_value())
	player.get_tree().create_timer(0.5 * (min(player.centre_position.distance_to(target) / 250, 1))).timeout.connect(_on_timeout)

func _on_timeout() -> void:
	var affinity = player.stats_component.get_damage_affinity(DAMAGE_TYPE).get_final_value()
	var damage_data = DamageData.new(damage * affinity, DAMAGE_TYPE)
	var effect_data = EffectData.new(effect, chance)
	var impact_data = ImpactData.new([damage_data], knockback, [effect_data])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.init(target, player.looking_at, impact_data, player.faction, false)
	ProjectileHandler.add_projectile(projectile)

func _on_casted():
	has_charged = true
