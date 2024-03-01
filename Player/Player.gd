extends Area2D

class_name Player

@export var vel:float=100
var screenSize:Vector2

signal scored

#region New Code Region
var sprite:AnimatedSprite2D
var sound: AudioStreamPlayer2D
#endregion

#region Process Variables
var movementDirection:Vector2=Vector2(0,0)
#endregion

# Called when the node enters the scene tree for the first time.
func _ready():
	_collectNodes()
	screenSize=get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movementDirection.y=0
	if Input.is_action_pressed("ui_up"):
		movementDirection.y-=1
	if Input.is_action_pressed("ui_down"):
		movementDirection.y+=1
	if movementDirection.y!=0:
		sprite.play()
		if movementDirection.y>0:
			sprite.animation="Down"
		else:
			sprite.animation="Up"
	else:
		sprite.stop()
	pass
	
func _physics_process(delta):
	position+=movementDirection.normalized()*vel
	position.y=clamp(position.y,0,screenSize.y)
	
	pass

func _collectNodes():
	sprite=$sprite as AnimatedSprite2D
	sound=$AudioStreamPlayer2D as AudioStreamPlayer2D
	pass
