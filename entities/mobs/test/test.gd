extends Mob

@export var state_component: StateComponent

func _ready():
	state_component.init()

func _physics_process(delta):
	state_component.process_physics(delta)