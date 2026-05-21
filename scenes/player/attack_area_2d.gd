class_name AttackArea

extends Area2D


func _ready() -> void:
	#body_entered.connect( _on_body_entered )
	
	monitorable=true
	monitoring=true
	
	pass
	
func _process(_delta: float) -> void:
	#do something like follow player and decide on attack
	pass
func _on_body_entered():
	 #gives damage to enemy or take_damage
	pass
