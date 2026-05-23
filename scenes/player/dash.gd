class_name PlayerStateDash extends PlayerState



@export var duration:float=0.30 #this is the duration the character uses to dash 
@export var dash_time:float=300
@export var speed:float=500
#@export var dash_distance:float=

var direction:float=5.0
var effect_time:float=0.05
var effect_duration:float=0.05
var time:float=0.0



func init() -> void:
	pass
	
func enter():
	
	player.animated_sprite_2d.play("dash")
	
	time = duration
	effect_time=0.0
	get_dash_direction()
	
	player.gravity_multiplier=0.0
	player.velocity.y=0.0
	player.dash_count += 1
	
	var anim=player.animated_sprite_2d
	player.sprite_2d.texture=anim.sprite_frames.get_frame_texture(anim.animation, anim.frame)
	
	player.sprite_2d.tween_color()
	
	pass
	
func exit():
	player.gravity_multiplier=1.0
	player.dash_cooldown_timer = player.dash_cooldown
	
	pass
	
	
func handle_input(_event: InputEvent) ->PlayerState:
	
	return next_state
	
func process(_delta: float) -> PlayerState:
	
	time -=_delta
	if time<=0:
		if player.is_on_floor():
			return idle
		else:
			return fall
			
	effect_time -= _delta
	if effect_time <= 0:
		effect_time = effect_duration
		player.sprite_2d.ghost()
	
		
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x =  speed  * direction 
	return next_state


func get_dash_direction():
	direction=1.0
	if player.animated_sprite_2d.flip_h==true:
		direction = -1.0
	pass
