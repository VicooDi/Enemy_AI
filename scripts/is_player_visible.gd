class_name isPlayerVisible
extends ConditionLeaf

@export var player_detection_range: float = 200.0
@export var vision_cone_angle:float = 45.0

func tick(actor: Node, blackboard: Blackboard) -> int:
	#get player
	var player = get_owner().get_node_or_null("player")
	if not player:
		return FAILURE
	
	#get distance to player
	var to_player = player.global_position - actor.global_position
	var dist = to_player.length()
	#print("distance to player :",dist)
	if(dist > player_detection_range):
		#print("too far!")
		return FAILURE
	
	#get field of view
	var forward_dir = Vector3.FORWARD.rotated(Vector3.UP, -90)
	var angle_to_player = forward_dir.angle_to(to_player.normalized())
	#print("angle to player :",rad_to_deg(angle_to_player))
	if(abs(angle_to_player) > deg_to_rad(vision_cone_angle)):
		#print("outside FOV!")
		return FAILURE
	
	#save pos to blackboard
	blackboard.set_value("playerPos", player.global_position)
	blackboard.set_value("playerDetected", true)
	
	#print("found!")
	
	return SUCCESS
