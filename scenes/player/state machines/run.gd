class_name PlayerStateRun

extends PlayerState


func init() -> void:
	pass

func enter():
	#play animations
	player.animated_sprite_2d.play("run")
	pass
	
	
func exit():
	#exit the state
	pass
	
	
	
func process(_delta: float) -> PlayerState:
	if player.direction.x==0:
		return idle
	#elif  player.direction.y>0.5:
		#return crouch
	#crouch state here
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x= player.direction.x * player.move_speed 
	if player.is_on_floor()==false:
		return fall
		
	return next_state
	
	
func handle_input(event: InputEvent) ->PlayerState:
	if event.is_action_pressed( "jump" ):
		return jump
	return next_state
