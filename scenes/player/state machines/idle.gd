class_name PlayerStateIdle extends PlayerState

func init() -> void:
	pass

func enter():
	#play animation
	player.animated_sprite_2d.play("idle")
	pass
	
	
func exit():
	pass
	
func handle_input(_event: InputEvent) ->PlayerState:
	#handle other inputs
	if _event.is_action_pressed("jump") and player.is_on_floor():
		return jump
	return next_state
	
func process(_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	elif player.direction.y>0.5:
		return crouch
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x=0
	if player.is_on_floor()==false:
		return fall
	
	return next_state
	
	
