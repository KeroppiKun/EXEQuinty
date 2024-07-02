extends CharacterBody2D

var moving = false
var input_dir
var grid_position = Vector2i()
var moveable = true

func _physics_process(delta: float) -> void:
	input_dir = Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_down"):
		input_dir = Vector2.DOWN
		($NextTileCheckRayCast as RayCast2D).target_position = input_dir * 32
		vetrtical_move()
	if Input.is_action_just_pressed("ui_up"):
		input_dir = Vector2.UP
		($NextTileCheckRayCast as RayCast2D).target_position = input_dir * 32
		vetrtical_move()
	if Input.is_action_just_pressed("ui_left"):
		input_dir = Vector2.LEFT
		($NextTileCheckRayCast as RayCast2D).target_position = input_dir * 32
		horizonal_move()
	if Input.is_action_just_pressed("ui_right"):
		input_dir = Vector2.RIGHT
		($NextTileCheckRayCast as RayCast2D).target_position = input_dir * 32
		horizonal_move()
	
	_check_next_tile()
	
	var groundObj = ($GroundCheckRayCast as RayCast2D).get_collider()
	if groundObj is Node:
		if groundObj.is_in_group("Tile"):
			grid_position = groundObj.grid_position
	

func horizonal_move():
	if input_dir:
		if moving == false:
			moving = true
			var tween = create_tween()
			tween.tween_property(self,"position",position + input_dir * Grobal.HORIZONAL_TILE_SIZE,0.1)
			tween.tween_callback(moving_false)

func vetrtical_move():
	if input_dir:
		if moving == false:
			moving = true
			var tween = create_tween()
			tween.tween_property(self,"position",position + input_dir * Grobal.VERTICAL_TILE_SIZE,0.1)
			tween.tween_callback(moving_false)

func moving_false():
	moving = false

func _check_next_tile():
	#($NextTileCheckRayCast as RayCast2D).target_position = input_dir * 32
	if ($NextTileCheckRayCast as RayCast2D).is_colliding():
		var nextObj = ($NextTileCheckRayCast as RayCast2D).get_collider()
		if nextObj is Node:
			if nextObj.is_in_group("Tile"):
				print(nextObj.tileType)
				return nextObj
	return null
