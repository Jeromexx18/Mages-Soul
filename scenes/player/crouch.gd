class_name PlayerStateCrouch extends PlayerState



# @export_category()


func init() -> void:
	pass
	
func enter():
	player.animated_sprite_2d.play("crouch")
	player.collision_stand_2d.disabled =true
	player.collision_crouch_2d.disabled=false
	pass
	#animation here
func exit():
	player.collision_stand_2d.disabled=false
	player.collision_crouch_2d.disabled=true
	pass
	
	
func handle_input(_event: InputEvent) ->PlayerState:
	#input from the player here 
	if _event.is_action_pressed("dash")and player.can_dash():
		return dash
	if _event.is_action_pressed("jump"):  
		return jump
		#do something
	return next_state
	
func process(_delta: float) -> PlayerState:
	# the function processing the 
	if player.direction.y <0.5:
		return idle
	return next_state

func physics_process(_delta: float) -> PlayerState:
	var deceleration_rate:float=10
	#do something
	player.direction.x -= player.velocity.x * _delta* deceleration_rate
	if !player.is_on_floor():
		return fall
	return next_state
