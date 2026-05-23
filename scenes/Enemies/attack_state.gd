# AttackState.gd
extends NodeState

@onready var character_body_2d : CharacterBody2D = get_parent().get_parent() as CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var attack_cooldown: float = 1.0  # seconds between attacks
@export var damage: int = 10

var player: CharacterBody2D
var cooldown_timer: float = 0.0
var can_attack: bool = true

func on_process(_delta: float):
	# count down the cooldown
	if !can_attack:
		cooldown_timer -= _delta
		if cooldown_timer <= 0.0:
			can_attack = true

func on_physics_process(_delta: float):
	# stop horizontal movement while attacking
	character_body_2d.velocity.x = move_toward(
		character_body_2d.velocity.x, 0, 200 * _delta
	)

	# face the player while in attack range
	if player:
		if character_body_2d.global_position.x > player.global_position.x:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false

	# trigger attack if cooldown is ready
	if can_attack:
		_do_attack()

func _do_attack():
	can_attack = false
	cooldown_timer = attack_cooldown
	animated_sprite_2d.play("attack_1")

	# deal damage when attack animation hits
	# connect to animation frame signal or use a hitbox Area2D
	#if player and player.has_method("take_damage"):
		#player.take_damage(damage)

func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	can_attack = true   # reset so enemy attacks immediately on entry
	cooldown_timer = 0.0

func exit():
	can_attack = true
	cooldown_timer = 0.0
