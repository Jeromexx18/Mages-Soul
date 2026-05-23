extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine
var is_following : =true

func _on_attack_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("attack")
		#character_body_2d.move_and_slide()

func _on_attack_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("idle")


func _on_follow_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("follow")
	
	
	pass # Replace with function body.
