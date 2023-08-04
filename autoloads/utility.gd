extends Node


func get_closest_body(this: Node2D ,bodies: Array[Node2D]) -> Node2D:
	if bodies.size() == 1:
		return bodies[0]
	var closest = bodies[0]
	for body in bodies:
		if this.position.distance_to(body.position) < this.position.distance_to(closest.position):
			closest = body
	return closest
