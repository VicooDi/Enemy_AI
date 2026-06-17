extends ActionLeaf

@export var point_A:Vector3 = Vector3(0.0,2.0,0.0)
@export var point_B:Vector3 = Vector3(2.0,2.0,0.0)


func tick(actor: Node, blackboard: Blackboard) -> int:
	if(blackboard.get_value("is_at_ptA")):
		return go_pt_B(blackboard, actor)
	else:
		return go_pt_A(blackboard, actor)
	

func go_pt_A(blackboard, actor):
	print("going to point A")
	
	var dir = (point_A - actor.global_position).normalized()
	actor.velocity = dir * 80.0 * get_physics_process_delta_time()
	actor.move_and_slide()
	
	var forward_dir = Vector3.FORWARD.rotated(Vector3.UP, -90)
	#actor.rotation.y = lerp(actor.rotation.y, dir.angle_to(point_B), 0.1)
	actor.rotation.y = forward_dir.angle_to(dir)
	print(rad_to_deg(forward_dir.angle_to(dir)))
	
	if(vec_approx(actor.global_position, point_A)):
		blackboard.set_value("is_at_ptA", true)
		blackboard.set_value("is_at_ptB", false)
		
		return SUCCESS
	return RUNNING
	
func go_pt_B(blackboard, actor):
	print("going to point B")
	
	var dir = (point_B - actor.global_position).normalized()
	actor.velocity = dir * 80.0 * get_physics_process_delta_time()
	actor.move_and_slide()
	
	var forward_dir = Vector3.FORWARD.rotated(Vector3.UP, -90)
	#actor.rotation.y = lerp(actor.rotation.y, dir.angle_to(point_A), 0.1)
	actor.rotation.y = forward_dir.angle_to(dir)
	print(rad_to_deg(forward_dir.angle_to(dir)))
	
	if(vec_approx(actor.global_position, point_B)):
		blackboard.set_value("is_at_ptB", true)
		blackboard.set_value("is_at_ptA", false)
		
		return SUCCESS
	return RUNNING


func vec_approx(a: Vector3, b: Vector3) -> bool:
	return abs((a - b).length()) < 0.05
