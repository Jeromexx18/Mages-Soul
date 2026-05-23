class_name PlayerStateAttack extends PlayerState


func init() -> void:
	pass
	
func enter():
	if player.is_action_pressed("attack"):
		%AttackArea.activate
		return
	#play animation here
	pass
	
func exit():
	player.animated_sprite_2d.play("attack_1")
	pass
	
	
func handle_input(_event: InputEvent) ->PlayerState:
	
	return next_state
	
func process(_delta: float) -> PlayerState:
	
	return next_state

func physics_process(_delta: float) -> PlayerState:
	
	return next_state
func do_attack():
	pass
