@tool
extends Node2D

@export var BattleGroundTileSize = Vector2i(10,10)
const Tile_scn = preload("res://Scenes/tile.tscn")
var tile_array:Array[Tile]
signal completeCreateStage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CreateStage()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func CreateStage():
	for y in BattleGroundTileSize.y:
		for x in  BattleGroundTileSize.x:
			var tile: Tile = Tile_scn.instantiate()
			tile.position = Vector2(x * Grobal.HORIZONAL_TILE_SIZE,y * Grobal.VERTICAL_TILE_SIZE)
			tile.position = tile.position + Vector2(Grobal.HORIZONAL_TILE_SIZE / 2,-Grobal.VERTICAL_TILE_SIZE / 2)
			add_child(tile)
			tile.grid_position = Vector2i(x,y)
			if x <= BattleGroundTileSize.x / 2 - 1:
				tile._set_tileType(tile.TILETYPE.BLUE)
			else:
				tile._set_tileType(tile.TILETYPE.RED)
			tile_array.push_back(tile)
	emit_signal("completeCreateStage")
