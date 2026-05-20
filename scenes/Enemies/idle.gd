class_name IdleState extends EnemyState



func _init() -> void:
	pass
	
func enter():
	pass
	
func exit():
	pass
	
	
func handle_input(_event: InputEvent) ->EnemyState:
	
	return next_state
	
func process(_delta: float) -> EnemyState:
	
	return next_state

func physics_process(_delta: float) -> EnemyState:
	
	return next_state
