extends State

@export var sprite: Sprite2D
@export var animation_tree: AnimationTree
@export var velocity: VelocityComponent
@export var idle: State
@export var jump_strength: RangeProvider
var is_finished := false
var is_jumping := false

func enter() -> void:
  entity.looking_at = Vector2(randi() % 100 - 50, randi() % 100 - 50).normalized()
  animation_tree['parameters/move/blend_position'] = entity.looking_at.x
  animation_tree['parameters/playback'].travel('move')
  animation_tree.animation_finished.connect(on_finished, CONNECT_ONE_SHOT)

func exit() -> void:
  is_finished = false

func process_physics(_delta: float) -> State:
  if is_finished:
    return idle
  if !is_jumping:
    velocity.accelerate_in_direction(Vector2.ZERO)
  velocity.move(entity)
  return null

func jump() -> void:
  is_jumping = true
  velocity.velocity = (entity.looking_at * jump_strength.execute())

func land() -> void:
  is_jumping = false

func on_finished(_anim_name: StringName) -> void:
  is_finished = true