extends Resource
class_name Attribute

signal updated(final_value: float)

@export var raw_value: float = 0
@export var multiplier_value: float = 1
@export var min_value: float = pow(-2, 31)
@export var max_value: float = pow(2, 31)-1
@export var modifiers: Array[AttributeModifier]


func _init(_raw := 0.0, _multiplier := 1.0, _min := pow(-2, 31), _max := pow(2, 31)-1) -> void:
	raw_value = _raw
	multiplier_value = _multiplier
	min_value = _min
	max_value = _max


## Returns the final attribute value after modifiers are applied.
func get_final_value() -> float:
	var temp_base = raw_value
	var temp_multiplier = multiplier_value
	for modifier in modifiers:
		match modifier.operation:
			Enums.OperationType.Addition:
				temp_base += modifier.value
			Enums.OperationType.Multiplication:
				temp_multiplier += modifier.value
			_:
				break
	var total = temp_base * temp_multiplier
	for modifier in modifiers:
		if modifier.operation == Enums.OperationType.Set:
			total = modifier.value
	return clamp(total, min_value, max_value)


## Adds a modifier to the attribute
func add_modifier(modifier: AttributeModifier) -> void:
	modifiers.append(modifier)
	updated.emit(get_final_value())


## Removes a modifier from the attribute
func remove_modifier(uid: String) -> void:
	var trash = []
	for modifier in modifiers:
		if modifier.uid == uid:
			trash.append(modifier)
	for modifier in trash:
		modifiers.erase(modifier)
	updated.emit(get_final_value())
