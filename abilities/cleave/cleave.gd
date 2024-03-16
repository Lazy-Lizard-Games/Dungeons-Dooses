extends Ability

## The cleave ability for the warrior.

## The projectile that will be created when the ability is casted.
@export var cleave_projectile_scene: PackedScene
## The time in seconds it takes to cast the ability.
@export var cast_time: float
## The time in seconds it takes to cast the ability.
@export var recharge_time: float
@onready var cast_timer: Timer = $CastTimer
@onready var recharge_timer: Timer = $RechargeTimer

func _ready():
  cast_timer = $CastTimer
  recharge_timer = $RechargeTimer

func cast() -> void:
  is_casting = true
  cast_timer.start(cast_time)

func recharge() -> void:
  is_recharging = true
  recharge_timer.start(recharge_time)

func _on_cast_timer_timeout():
  is_casting = false
  casted.emit()
  var cleave_projectile: Projectile = cleave_projectile_scene.instantiate()
  cleave_projectile.init(caster, global_position, caster.looking_at)
  ProjectileHandler.add_projectile(cleave_projectile)
  recharge()

func _on_recharge_timer_timeout():
  is_recharging = false
  recharged.emit()
  end()
