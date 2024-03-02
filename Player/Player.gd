extends Area2D

class_name Player

@export var cars_group_name:String="cars"
@export var vel:float=100
@export var x_position:float=640

@export var up_action_name:String="ui_up"
@export var down_action_name:String="ui_down"

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
	_reset_position()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movementDirection.y=0
	if Input.is_action_pressed(up_action_name):
		movementDirection.y-=1
	if Input.is_action_pressed(down_action_name):
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

func _reset_position():
	position.x=x_position
	position.y=696

func _on_body_entered(body:Node2D):
	if body.is_in_group(cars_group_name):
		sound.play(0)
	else:
		emit_signal("scored")
	_reset_position()
	pass # Replace with function body.
