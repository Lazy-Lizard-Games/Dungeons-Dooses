extends EntityAction
class_name ModifyEntity

## Describes general structure of modifying action types.

## Attribute modifier to modify attribute by.
@export var modifier: AttributeModifier
## If modifier should be added or removed from the attribute.
@export var should_add: bool = true
