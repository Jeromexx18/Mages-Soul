class_name Player extends CharacterBody2D

#@export_category()
#region /// some standard variables

@onready var sprite_2d: PlayerSprite = $Sprite2D #this is for the dashng

@export var move_speed:int=200
var direction:Vector2=Vector2.ZERO
@export var gravity:float=900
var screen_size
@export var max_fall_velocity:float=500

@export var jump_velocity:float=600
#@export var velocity=Vector2.ZERO
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var gravity_multiplier:float=1.0
#endregion

#region /// standing and croutch collisions

@onready var collision_stand_2d: CollisionShape2D = $CollisionStand2D
@onready var collision_crouch_2d: CollisionShape2D = $CollisionCrouch2D



#endregion

#signal damage_taken


#abiliities
#region 
@export var dash_cooldown:float=0.0
var dash_cooldown_timer:float=0.0

@export var dash:bool=true
var dash_count:int=0
var can_magic:bool=false

var can_double_jump:bool=false
var can_take_damage:bool=false
var special_ability:bool=false

#endregion


#region /// state machine variable
var states: Array[PlayerState]
var current_state:PlayerState:
	get: return states.front()
	
var previous_state:PlayerState:
	get: return states[0]
	
	
#endregion

#region /// special abilities




func _ready() -> void:
	#if get_tree().get_first_node_in_group("Player")!=self:
		#self.queue_free()
	initialize_states()
	
	pass
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	
	pass

func _process(_delta: float) -> void:
	#sprite_2d.visible=false
	#if Input.is_action_pressed("right"):
		#velocity.x+=1
	#if Input.is_action_pressed("left"):
		#velocity.x-=1
	#if Input.is_action_pressed("jump"):
		#velocity.y=+2
	#if Input.is_action_pressed("jump"):
		#velocity.y=4*gravity
	if dash_cooldown_timer>0:
		dash_cooldown_timer -= _delta
	
	change_state (current_state.process(_delta))
	update_direction()
	pass
	
func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * gravity_multiplier* _delta
		
	#velocity increase when falling
	#velocity.x= move_speed*direction.x
	
	velocity.y=clampf(velocity.y, -1000.0, max_fall_velocity)
	
	move_and_slide()
	change_state (current_state.physics_process(_delta))
	pass




func unhandled_input(_event: InputEvent) -> void:
	pass
	
func initialize_states():
	
	for c in $States.get_children():
		if c is PlayerState:
			states.append(c)
			c.player=self
	
	if states.size()==0:
		return
		
	for state in states:
		state.init()
		
	change_state(current_state)
	current_state.enter()
	pass
	
	
	#func intialize_states():
	#for c in $States.get_children():
		#if c is PlayerState:
			#states.append(c)
			#c.player=self
			#
	#if states.size()==0:
		#return
		#
	##intilialize all states
	#for state in states:
		#state.init()
	#
	#change_state(current_state)
	#current_state.enter()
	
	
func change_state( new_state: PlayerState ):
	if new_state == null:
		return
	elif new_state==current_state:
		return
	
	if current_state:
		current_state.exit()
	#push state in front
		states.push_front(new_state)
		
		#current_state.enter()
		states.resize(4)
		new_state.enter()
		
		%Label.text=current_state.name
	pass

func update_direction()->void:
	
	var prev_direction=direction
	var x_axis=Input.get_axis("left","right")
	var y_axis=Input.get_axis("jump","down")
	direction=Vector2(x_axis,y_axis)
	if prev_direction.x !=direction.y:
		if direction.x<0:
			animated_sprite_2d.flip_h=true
			sprite_2d.flip_h=true
		if direction.x>0:
			sprite_2d.flip_h=false
			animated_sprite_2d.flip_h=false
	
	pass


func can_dash()->bool:
	
	if dash == false or dash_count >0 or dash_cooldown_timer>0 :
		return false
	return true
