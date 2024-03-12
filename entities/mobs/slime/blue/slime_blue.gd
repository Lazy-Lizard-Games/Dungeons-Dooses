extends Mob
class_name Slime

@export var state_component: StateComponent

func _ready():
  super()
  state_component.init(self)

func _process(delta):
  state_component.process_frame(delta)

func _physics_process(delta):
  state_component.process_physics(delta)

func _unhandled_input(event):
  state_component.process_input(event)