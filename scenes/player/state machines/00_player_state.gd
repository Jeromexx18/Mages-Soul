class_name PlayerState extends Node


var player:Player
var next_state:PlayerState


@onready var run: PlayerStateRun = %Run
#@onready var fall: PlayerStateFall = %Fall
@onready var fall: PlayerStateFall = %fall

#@onready var crouch:PlayerStateCrouch=%Crouch
@onready var idle: PlayerStateIdle = %Idle

@onready var jump: PlayerStateJump = %Jump
@onready var crouch: PlayerStateCrouch = %crouch
@onready var attack: PlayerStateAttack = %attack





func _init() -> void:
	pass
	
func enter():
	pass
	
func exit():
	pass
	
	
func handle_input(_event: InputEvent) ->PlayerState:
	
	return next_state
	
func process(_delta: float) -> PlayerState:
	
	return next_state

func physics_process(_delta: float) -> PlayerState:
	
	return next_state
