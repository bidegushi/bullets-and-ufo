extends Control

@export var loadding_label : Label
@export var loadding_time : float = 0.5
@export var loadding_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(loadding_time).timeout
	get_tree().change_scene_to_packed(loadding_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	loadding_label.text="加载中 loadding "
	for i in range(3):
		loadding_label.text+=str(". ")
		await get_tree().create_timer(0.2).timeout
