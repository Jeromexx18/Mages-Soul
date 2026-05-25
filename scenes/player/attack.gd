class_name PlayerStateAttack extends PlayerState

@onready var attack_area: AttackArea = %AttackArea
@onready var collision_shape_2d: CollisionShape2D = $"../../AttackArea/CollisionShape2D"
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D



var speed : float = 150
@export var combo_time_window :float=0.2
var timer : float = 0
var combo : int =0

func init() -> void:
	
	
	pass
	
func enter() ->void:
	do_attack()
	
	player.animated_sprite_2d.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)
	#play animation here
	pass
	
func exit():

	
	next_state = null
	pass
	
	
func handle_input(_event: InputEvent) ->PlayerState:
	if _event.is_action("attack"):
		timer = combo_time_window
	return next_state
	
func process(delta: float) -> PlayerState:
	timer -= delta
	return next_state

func physics_process(_delta: float) -> PlayerState:
	
	return null
	
	
func do_attack():
	
	if not player.is_on_floor():
		player.animated_sprite_2d.play( "jump_attack")
		return
		
	else :
		player.animated_sprite_2d.play( "attack_1")
	
	return next_state
	

	
func _end_attack():
	#if timer > 0:
		#combo = wrapi(combo + 1, 0, 2)
		#do_attack()
	#else:
		next_state = idle
	
func _on_animation_finished():
	#_anim_name: String) ->void:
	_end_attack()
	
	pass
