class_name WaitAtPatrolPoint
extends ActionLeaf

@export var wait_time: float = 2.0
var current_wait_time: float = 0.0

var waiting = false

func tick(actor: Node, blackboard: Blackboard) -> int:
	# Check if we just reached the patrol point
	if !waiting:
		waiting = true
		current_wait_time = 0.0
	
	# Increment wait time
	current_wait_time += get_physics_process_delta_time()
	
	print("wai...")
	# Check if we've waited long enough
	if current_wait_time >= wait_time:
		waiting = false
		return SUCCESS
	
	return RUNNING
