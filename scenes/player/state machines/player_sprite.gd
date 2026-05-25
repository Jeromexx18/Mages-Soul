class_name  PlayerSprite extends Sprite2D

var sprite_2d : bool =true  
var tween:Tween

var sprite_2d_visible = true


func _ready() -> void:
	self.visible = false
	pass
	
func tween_color(duration:float=0.5, color:Color= Color(0.0, 3.5, 0.95)):
	if tween:
		tween.kill()
	modulate=color
	tween=create_tween()
	tween.tween_property(self,"modulate", Color.WHITE,duration)
	
	pass

func _ghost()->void:
	self.visible = true
	
	
	var anim:AnimatedSprite2D=get_parent() as AnimatedSprite2D
	var frame_texture = anim.sprite_frames.get_frame_texture(anim.animation, anim.frame)
	if frame_texture == null:
		return
	texture=frame_texture
	
	var effect:Node2D=Node2D.new()
	var p:Node2D=get_parent()
	
	p.add_sibling( effect )
	effect.z_index=-1
	effect.global_position=p.global_position
	effect.modulate = Color (1.0, 0.0, 0.95, 0.72)
	
	var sprite_copy:Sprite2D=duplicate() as Sprite2D
	effect.add_child( sprite_copy )
	
	var T: Tween=create_tween()
	T.set_ease(Tween.EASE_OUT)
	T.tween_property(effect, "modulate", Color ( 1, 1, 1, 0),0.2)
	T.chain().tween_callback(effect.queue_free)
