extends Node2D

class_name LevelMain

@export var fast_car_range_of_speeds:Vector2=Vector2(700,710)
@export var slow_car_range_of_speeds:Vector2=Vector2(300,310)

const new_car:PackedScene=preload("res://Enemies/car.tscn")

const slow_tracks:Array[int]=[600,544,438,324,384,216,160]
const fast_tracks:Array[int]=[488,272,104]


var player1_score=0
var player2_score=0

#region Subnodes references
var result_label:Label
var p1_points_label:Label
var p2_points_label:Label
var reset_button:Button

var background_music_player:AudioStreamPlayer
#var collision_sound_player:AudioStreamPlayer
var score_sound_player:AudioStreamPlayer
var win_sound_player:AudioStreamPlayer

var fast_car_timer:Timer
var slow_car_timer:Timer
#endregion

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	_initialize_variables()
	reset_button.hide()
	background_music_player.play()
	pass # Replace with function body.

func _initialize_variables():
	result_label=$CanvasLayer/Result as Label
	p1_points_label=$CanvasLayer/P1_points as Label
	p2_points_label=$CanvasLayer/P2_points as Label
	reset_button=$CanvasLayer/Reset_button as Button
	
	background_music_player=$AudioPlayers/Background_music as AudioStreamPlayer
	#collision_sound_player=$AudioPlayers/Collision as AudioStreamPlayer
	score_sound_player=$AudioPlayers/Score as AudioStreamPlayer
	win_sound_player=$AudioPlayers/Win as AudioStreamPlayer
	
	fast_car_timer=$Fast_car_timer as Timer
	slow_car_timer=$Slow_car_timer as Timer
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player1_scored():
	if player1_score<10:
		player1_score+=1
		p1_points_label.text=str(player1_score)
		score_sound_player.play()
	else:
		background_music_player.stop()
		result_label.text="Player1 win"
		win_sound_player.play()
		fast_car_timer.stop()
		slow_car_timer.stop()
		reset_button.show()
	pass # Replace with function body.


func _on_player2_scored():
	if player2_score<10:
		player2_score+=1
		p2_points_label.text=str(player2_score)
		score_sound_player.play()
	else:
		background_music_player.stop()
		result_label.text="Player2 win"
		win_sound_player.play()
		fast_car_timer.stop()
		slow_car_timer.stop()
		reset_button.show()
	pass # Replace with function body.


func _on_fast_car_timer_timeout():
	var instanced_car:Car=new_car.instantiate() as Car
	instanced_car.position.x=-10
	instanced_car.position.y=fast_tracks[randi()%fast_tracks.size()]
	instanced_car.linear_velocity=Vector2(randf_range(fast_car_range_of_speeds.x,
	fast_car_range_of_speeds.y),0)
	add_child(instanced_car)
	#print(instanced_car)
	pass # Replace with function body.


func _on_slow_car_timer_timeout():
	var instanced_car:Car=new_car.instantiate() as Car
	instanced_car.position.x=-10
	instanced_car.position.y=slow_tracks[randi()%slow_tracks.size()]
	instanced_car.linear_velocity=Vector2(randf_range(slow_car_range_of_speeds.x,
	slow_car_range_of_speeds.y),0)
	add_child(instanced_car)
	pass # Replace with function body.


func _on_reset_button_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.
