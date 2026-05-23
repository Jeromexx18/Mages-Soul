class_name NodeFiniteStateMachine
extends Node

@export var initial_node_state : NodeState

var node_states : Dictionary = {}
var character_body_2d : CharacterBody2D
var current_node_state : NodeState
var current_node_state_name : String


func _ready():
	character_body_2d = get_parent() as CharacterBody2D
	for child in get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child
	if initial_node_state:
		current_node_state = initial_node_state
		current_node_state_name = initial_node_state.name.to_lower()
		current_node_state.enter()


func _process(delta):

	if current_node_state:
		current_node_state.on_process(delta)


func _physics_process(delta):

	if current_node_state:
		current_node_state.on_physics_process(delta)
	character_body_2d.move_and_slide()
		
	if current_node_state_name != "":
		return
		#print("Current State: ", current_node_state_name)
	

func transition_to(node_state_name : String):

	node_state_name = node_state_name.to_lower()

	if node_state_name == current_node_state_name:
		return

	var new_node_state = node_states.get(node_state_name)

	if !new_node_state:
		#print("State not found: ", node_state_name)
		return "idle"

	if current_node_state:
		current_node_state.exit()

	new_node_state.enter()

	current_node_state = new_node_state
	current_node_state_name = node_state_name
