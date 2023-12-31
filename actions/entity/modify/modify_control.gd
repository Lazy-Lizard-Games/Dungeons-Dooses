extends ModifyEntity
class_name ModifyControl

## Sets the control of the entity to value.

func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	if should_add:
		entity.velocity_component.control.add_modifier(modifier)
	else:
		entity.velocity_component.control.remove_modifier(modifier)
