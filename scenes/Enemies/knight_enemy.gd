
extends CharacterBody2D

var move_speed:float=100
var direction:Vector2=Vector2.ZERO
var run_speed:float=25.0
var attacks=["attack_1", "attack_2"]

enum states{PATROL, CHASE, ATTACK, DEAD}

var state =states.PATROL
var target=null
var player=null
var patrol_points=[]
var current_patrol_points=0

func  _ready() -> void:
	
	pass
	
func process(_delta: float) -> void:
	
	on_detect_radius_entered(player)
	
	pass
	
func physics_process(_delta: float) -> void:
	
	pass


func on_detect_radius_entered(_area: Area2D) -> void:
	
	print('Player entered')
	pass # Replace with function body.
