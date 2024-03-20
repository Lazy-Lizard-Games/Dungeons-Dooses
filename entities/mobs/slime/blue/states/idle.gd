extends State

@export var animation_tree: AnimationTree
@export var state: StateComponent
@export var velocity: VelocityComponent
@export var move: State
@export var idle_move_interval: RangeNumber
var idle_move_timer: Timer

func _ready():
  idle_move_timer = Timer.new()
  add_child(idle_move_timer)
  idle_move_timer.timeout.connect(on_idle_move_timeout)

func enter() -> void:
  animation_tree['parameters/playback'].travel('idle')
  idle_move_timer.start(idle_move_interval.get_number())

func exit() -> void:
  idle_move_timer.stop()

func process_physics(_delta) -> State:
  velocity.accelerate_in_direction(Vector2.ZERO)
  velocity.move(entity)
  return null

func on_idle_move_timeout() -> void:
  state.change_state(move)
