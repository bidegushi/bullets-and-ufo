extends "res://scripts/plane/plane.gd"



func _ready() -> void:
	plane_velocity=120
	fire_cyc=3
	
	
	fire_Timer.wait_time=fire_cyc
	fire_Timer.one_shot=true

#功能函数
var is_firing : bool = false
func fire() -> void: #开火
	if  not is_firing: 
		is_firing=true
		var laser_beam=$LaserBeam2D
		if not is_game_over and Input.is_action_pressed("fire") and is_ok_to_fire:
			laser_beam.is_casting=true
			
			
			await get_tree().create_timer(0.8).timeout
			laser_beam.is_casting=false
			fire_Timer.start()
		is_firing=false
