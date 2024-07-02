extends CharacterBody2D

var moving = false
var input_dir
var grid_position = Vector2i()
var moveable = true

@onready var nextTileRay: RayCast2D = $NextTileCheckRayCast

func _physics_process(delta: float) -> void:
	input_dir = Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_down"):
		input_dir = Vector2.DOWN
		vetrtical_move()
	if Input.is_action_just_pressed("ui_up"):
		input_dir = Vector2.UP
		vetrtical_move()
	if Input.is_action_just_pressed("ui_left"):
		input_dir = Vector2.LEFT
		horizonal_move()
	if Input.is_action_just_pressed("ui_right"):
		input_dir = Vector2.RIGHT
		horizonal_move()
	
	var groundObj = ($GroundCheckRayCast as RayCast2D).get_collider()
	if groundObj is Node:
		if groundObj.is_in_group("Tile"):
			grid_position = groundObj.grid_position
	

func horizonal_move():
	if input_dir:
		var desired_step: Vector2 = input_dir * Grobal.HORIZONAL_TILE_SIZE / 2
		nextTileRay.target_position = desired_step
		nextTileRay.force_raycast_update()
		var nextTile = nextTileRay.get_collider()
		if nextTile is Tile:
			print(nextTile.walkable)
			if moving == false && nextTile.walkable:
				moving = true
				var tween = create_tween()
				tween.tween_property(self,"position",position + input_dir * Grobal.HORIZONAL_TILE_SIZE,0.1)
				tween.tween_callback(moving_false)

func vetrtical_move():
	if input_dir:
		var desired_step: Vector2 = input_dir * Grobal.HORIZONAL_TILE_SIZE / 2
		nextTileRay.target_position = desired_step
		nextTileRay.force_raycast_update()
		if moving == false && nextTileRay.is_colliding():
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
				return nextObj
	return null
