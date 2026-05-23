extends NodeState

@export var character_body_2d : CharacterBody2D = get_parent().get_parent() as CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var speed : int
var can_follow :bool = true
var player : CharacterBody2D
var max_speed : int


func on_process(_delta : float):
	pass

	
func on_physics_process(_delta : float):
	
	
	print("player:", player, "| char_body:", character_body_2d)
	if !player:
		return
		
	var direction : int = 0
	
	if character_body_2d.global_position > player.global_position:
		animated_sprite_2d.flip_h = true
		direction = -1
	elif character_body_2d.global_position.x < player.global_position.x:
		animated_sprite_2d.flip_h = false
		direction = 1
	
	animated_sprite_2d.play("follow")
	
	character_body_2d.velocity.x = direction * speed 
	character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_speed, max_speed)


func enter():
	if get_tree().get_nodes_in_group("Player").size() > 0:
		player = get_tree().get_nodes_in_group("Player")[0] as Player
	else:
		push_error("FollowState: No node found in group 'Player'")
	max_speed = speed + 20


#func enter():
	#var players = get_tree().get_nodes_in_group("Player")
	#print("Players found: ", players.size())
	#velocity
	

func exit():
	pass
