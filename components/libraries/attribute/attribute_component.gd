extends Node
class_name AttributeComponent

## Holds onto attributes and provides methods for indexing them.


## Adds the attribute as a child.
func add_attribute(attribute: Attribute) -> void:
	add_child(attribute)


## Removes the attribute as a child.
func remove_attribute(attribute: BaseButton) -> void:
	remove_child(attribute)


## Returns the first child attribute of the matching type or null if none found.
func get_attribute_by_type(type: Enums.AttributeType) -> Attribute:
	var attributes = get_children() as Array[Attribute]
	for attribute in attributes:
		if attribute.type == type:
			return attribute
	return null
