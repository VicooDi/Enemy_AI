extends ActionLeaf

@export var patrol_points:PackedVector3Array
var curr_patrol_pt = 0

@onready var navAgent: NavigationAgent3D = $"../../../../NavigationAgent3D"

func tick(actor: Node, blackboard: Blackboard) -> int:
	curr_patrol_pt = blackboard.get_value("crrPtrlPnt")
	if(curr_patrol_pt == null):
		curr_patrol_pt = 0

	navAgent.set_target_position(patrol_points[curr_patrol_pt])
	
	var dir = (navAgent.get_next_path_position() - actor.global_position).normalized()
	
	actor.velocity = dir * 80.0 * get_physics_process_delta_time()
	actor.move_and_slide()
	
	if(vec_approx(actor.global_position, patrol_points[curr_patrol_pt])):
		curr_patrol_pt+=1
		blackboard.set_value("crrPtrlPnt", curr_patrol_pt)
		print("Im here")
		return SUCCESS
	return RUNNING

func vec_approx(a: Vector3, b: Vector3) -> bool:
	print("Im not here")
	return abs((a - b).length()) < 1
