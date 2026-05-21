class_name PlayerStateFall extends PlayerState

#region /// standard fall variables
@export var fall_gravity_multiplier:float=1.600
@export var coyote_time:float=0.125
var gravity_variable
@export var jump_buffer_timer:float=0.2
#timers
@export var buffer_timer:float=0
@export var jump_buffer:float=0.2

@export var coyote_timer:float=0
var has_jumped:bool=true

func init() -> void:
	pass

func enter():
	
	var prev:PlayerState=player.previous_state
	#play animation here
	player.animated_sprite_2d.play("jump")
	player.animated_sprite_2d.pause()

	player.gravity_multiplier=fall_gravity_multiplier
	if prev==jump or prev == dash:
		coyote_timer=0
	else:
		coyote_timer=coyote_time
	pass
	
	
func exit():
	gravity_variable = player.gravity_multiplier
	player.gravity_multiplier=1.0
	buffer_timer=0
	
	pass


func handle_input(event: InputEvent) ->PlayerState:
	if event.is_action_pressed("dash") and player.can_dash():
		return dash
	
	if event.is_action_pressed("jump") and player.is_on_floor():
		if coyote_timer>0:
			return jump
		else:
			buffer_timer=jump_buffer_timer
	return next_state

func process(_delta: float) -> PlayerState:
	#set_jump_frame()
	coyote_timer -=_delta
	buffer_timer -=_delta
	return next_state
	
	
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x=player.direction.x * player.move_speed
	if player.is_on_floor():
		if buffer_timer > 0:
			return jump
		return idle 
	
	return next_state
	
	
#func set_jump_frame()->void:
	#var frame:float=remap(player.velocity.y,0.0,player.max_velocity,0.5,1.0)
	#player.animated_sprite_2d.seek(frame, true)
	#pass
	
