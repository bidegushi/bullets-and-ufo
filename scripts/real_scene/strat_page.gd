extends Control


#@export var start_to_play_scene : PackedScene 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_start_to_play_button_pressed() -> void:
	SceneManager.change_scene("plane_selector")
