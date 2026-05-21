class_name PlayerStateJump

extends PlayerState




func init() -> void:
	pass

func enter():
	#play animation here
	player.animated_sprite_2d.play("jump")
	player.animated_sprite_2d.pause()
	player.velocity.y= -player.jump_velocity
	
	if player.previous_state==fall and not Input.is_action_just_pressed("jump"):
		await get_tree().physics_frame
		player.velocity.y = 0.5
		player.change_state(fall)
		 
	pass
	
	
func exit():
	
	pass

func process(_delta: float) -> PlayerState:
	set_jump_frame()
	return next_state
	
func handle_input(event: InputEvent) ->PlayerState:
	if event.is_action_pressed("dash") :
		return dash
	if event.is_action_released( "jump" ) and player.velocity.y<=0 and player.is_on_floor() :
		player.velocity.y *= 0.5
		return fall
	return next_state


	
func physics_process(_delta: float) -> PlayerState:
	
	player.velocity.x = player.direction.x * player.move_speed
	if player.is_on_floor():
		return idle
	elif player.velocity.y > 0:
		return fall
	
	return next_state

func set_jump_frame() -> void:
	var frame_count = player.animated_sprite_2d.sprite_frames.get_frame_count("jump")

	var frame = remap( player.velocity.y,-player.jump_velocity,player.max_fall_velocity,0,frame_count - 1)

	frame = clamp(frame, 0, frame_count - 1)

	player.animated_sprite_2d.frame = int(frame)
	pass
#func set_jump_frame()->void:
	#var frame :float= remap (player.velocity.y, -jump_velocity,0.0,0.0,0.5)
	##frame remapping
	#player.animated_sprite_2d.seek(frame, true)
	#pass
