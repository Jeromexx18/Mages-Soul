class_name AttackArea

extends Area2D




func _ready() -> void:
	body_entered.connect( _on_body_entered )
	area_entered.connect( _on_body_entered )
	monitorable=false
	monitoring=true
	
	pass
	

func _on_body_entered(body : Node2D)->void:
	
	if body is DamageArea:
		body.take_damage(self)
		print("Damage")
		pass
	pass

func activate ( duration:float= 0.1)->void:
	set_active()
	await  get_tree().create_timer( duration ).timeout
	set_active ( true )
	monitoring=true
	
	pass

func set_active(value : bool = true)->void:
	monitoring = value
	visible = value
	pass

func flip(direction_x : float):
	if direction_x > 0:
		scale.x = 1
	elif direction_x < 0 :
		scale.x = -1
	
	pass
