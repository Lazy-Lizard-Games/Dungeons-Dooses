extends EntityAction
class_name ModifyEntity

## Describes general structure of modifying action types.

## Attribute modifier to modify attribute by.
@export var modifier: AttributeModifier
## If modifier is to be added or removed from the attribute.
@export var is_add: bool = true
