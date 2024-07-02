extends Area2D
class_name Tile

enum TILETYPE{
	BLUE,
	RED
}

var grid_position = Vector2i.ZERO
var tileType : TILETYPE
var walkable = true
@onready var tileSprite : Sprite2D = $TileSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#($Label as Label).text = str(grid_position)
	pass

func _update_tileType():
	#タイルの種類に合わせて更新
	if(tileType == TILETYPE.BLUE):
		tileSprite.modulate = Color.AQUA
		walkable = true
	if(tileType == TILETYPE.RED):
		tileSprite.modulate = Color.LIGHT_CORAL
		walkable = false

func _set_tileType(_tileType:TILETYPE):
	tileType = _tileType
	_update_tileType()
