class_name Enemy
extends CharacterBody2D

enum State {IDLE, FOLLOW, ATTACK}
var current_state : State = State.IDLE

var attack_timer : float = 0.0
var attack_cooldown : float = 0.2
var attack_index : int =0
var is_attacking : bool = false
@export var attack_duration : float = 0.6   # how long each attack animation plays
var in_cooldown : bool = false


# stats
@export var speed : int = 100
@export var gravity : float = 900

# references
@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D
var player : CharacterBody2D
var attacks : Array = ["attack_1", "attack_2"]






func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta

	match current_state:
		State.IDLE:_idle_state()
		State.FOLLOW:_follow_state()
		State.ATTACK:_attack_state(delta)
	move_and_slide()

# ---- STATES ----

func _idle_state() -> void:
	animated_sprite_2d.play("idle")
	velocity.x = move_toward(velocity.x, 0, 10)

func _follow_state() -> void:
	animated_sprite_2d.play("follow")
	if player.global_position.x > global_position.x:
		velocity.x = speed
		animated_sprite_2d.flip_h = false
	else:
		velocity.x = -speed
		animated_sprite_2d.flip_h = true

func _attack_state(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0, 10)
	
	if player.global_position.x > global_position.x:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	attack_timer -= delta

	if attack_timer <= 0:
		if in_cooldown:
			# cooldown finished — play next attack
			in_cooldown = false
			attack_index = (attack_index + 1) % attacks.size()
			animated_sprite_2d.play(attacks[attack_index])
			attack_timer = attack_duration
		else:# attack animation finished — start cooldown
			in_cooldown = true
			attack_timer = attack_cooldown







func _on_follow_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		current_state = State.FOLLOW
	pass # Replace with function body.


func _on_follow_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
		
		
		current_state = State.IDLE
	pass # Replace with function body.


func _on_attack_area_2d_body_entered(body: Node2D) -> void:

	if body.is_in_group("Player"):
		attack_index = 0
		attack_timer = attack_duration
		in_cooldown = false
		animated_sprite_2d.play(attacks[attack_index])
		current_state = State.ATTACK
		
		current_state = State.ATTACK
	pass # Replace with function body.


func _on_attack_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		current_state = State.FOLLOW
	pass # Replace with function body.
