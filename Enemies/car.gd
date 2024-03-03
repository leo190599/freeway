extends RigidBody2D

class_name Car

@export var possible_spries:Array[Texture2D]

var sprite:Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	_initialize_variables()
	if possible_spries.size()>0:
		sprite.texture=possible_spries[randi()%possible_spries.size()]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _initialize_variables():
	sprite=$Sprite2D as Sprite2D


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
