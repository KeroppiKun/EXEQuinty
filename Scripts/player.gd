extends CharacterBody2D
class_name Player

var moving = false
var input_dir
var grid_position = Vector2i()
var moveable = true
var tile_array:Array[Tile]

@onready var nextTileRay: RayCast2D = $NextTileCheckRayCast

func _physics_process(delta: float) -> void:
	#移動処理
	_move_update()
	
	var groundObj = ($GroundCheckRayCast as RayCast2D).get_collider()
	if groundObj is Node:
		if groundObj.is_in_group("Tile"):
			grid_position = groundObj.grid_position
	
	if Input.is_action_just_pressed("ui_select"):
		_change_tile()

func horizonal_move():
	if input_dir:
		#移動方向に合わせてレイを飛ばす向きを設定
		var desired_step: Vector2 = input_dir * Grobal.HORIZONAL_TILE_SIZE / 2
		nextTileRay.target_position = desired_step
		#レイの強制更新
		nextTileRay.force_raycast_update()
		#移動先のコリジョン情報を取得
		var nextTile = nextTileRay.get_collider()
		#タイルだった場合
		if nextTile is Tile:
			#移動可能タイルだった場合移動処理
			print(nextTile.walkable)
			if moving == false && nextTile.walkable:
				moving = true
				var tween = create_tween()
				tween.tween_property(self,"position",position + input_dir * Grobal.HORIZONAL_TILE_SIZE,0.1)
				tween.tween_callback(moving_false)

func vetrtical_move():
	if input_dir:
		var desired_step: Vector2 = input_dir * Grobal.VERTICAL_TILE_SIZE / 2
		nextTileRay.target_position = desired_step
		nextTileRay.force_raycast_update()
		var nextTile = nextTileRay.get_collider()
		if nextTile is Tile:
			if moving == false && nextTile.walkable:
				moving = true
				var tween = create_tween()
				tween.tween_property(self,"position",position + input_dir * Grobal.VERTICAL_TILE_SIZE,0.1)
				tween.tween_callback(moving_false)

func moving_false():
	moving = false

func _move_update():
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

func _set_tile_array(_tile_array : Array[Tile]):
	tile_array = _tile_array

func _change_tile():
	for i in tile_array.size():
		if tile_array[i].grid_position == grid_position + Vector2i(1,0):
			tile_array[i]._set_tileType(Tile.TILETYPE.RED)
