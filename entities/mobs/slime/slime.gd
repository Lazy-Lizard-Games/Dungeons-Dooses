class_name Slime
extends Mob

func _ready():
    state_component.init()

func _process(delta: float) -> void:
    state_component.process_frame(delta)

func _physics_process(delta: float) -> void:
    state_component.process_physics(delta)

func _input(event: InputEvent) -> void:
    state_component.process_input(event)
