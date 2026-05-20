class_name EnemyState extends Node



@onready var idle: EnemyState = %idle
@onready var attack: EnemyState = %attack
@onready var patrol: EnemyState = %Patrol




var enemy: Enemy
var next_state:EnemyState

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
