class_name  PlayerSprite extends Sprite2D

var sprite_2d : bool= false
var tween:Tween



func _ready() -> void:
	
	pass
	
func tween_color(duration:float=0.5, color:Color= Color(0.0, 3.5, 0.95)):
	if tween:
		tween.kill()
	modulate=color
	tween=create_tween()
	tween.tween_property(self,"modulate", Color.WHITE,duration)
	
	pass

func ghost()->void:
	
	
	var anim:AnimatedSprite2D=get_parent().animated_sprite_2d
	texture=anim.sprite_frames.get_frame_texture(anim.animation, anim.frame)
	var effect:Node2D=Node2D.new()
	var p:Node2D=get_parent()
	
	
	p.add_sibling( effect )
	effect.z_index=0
	effect.global_position=p.global_position
	effect.modulate = Color (0.0, 1.5, 0.95, 0.72)
	
	var sprite_copy:Sprite2D=duplicate() as Sprite2D
	sprite_copy.set_script(null)
	sprite_copy.visible=true
	
	effect.add_child( sprite_copy )
	
	var T: Tween=create_tween()
	T.set_ease(Tween.EASE_OUT)
	T.tween_property(effect, "modulate", Color ( 1, 1, 1, 0),0.2)
	T.chain().tween_callback(effect.queue_free)
