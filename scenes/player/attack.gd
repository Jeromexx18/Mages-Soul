class_name PlayerStateAttack extends PlayerState


func init() -> void:
	pass
	
func enter():
	#play animation here
	pass
	
func exit():
	pass
	
	
func handle_input(_event: InputEvent) ->PlayerState:
	
	return next_state
	
func process(_delta: float) -> PlayerState:
	
	return next_state

func physics_process(_delta: float) -> PlayerState:
	
	return next_state
