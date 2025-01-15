extends Control



#选择了普通飞机
func _on_normal_button_pressed() -> void:
	SceneManager.change_to_main("plane")
	



#选择了黄金飞机
func _on_vip_button_pressed() -> void:
	SceneManager.change_to_main("vip_plane")


func _on_blue_button_pressed() -> void:
	SceneManager.change_to_main("blue_plane")
