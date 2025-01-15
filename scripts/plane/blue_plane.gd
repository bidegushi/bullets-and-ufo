extends "res://scripts/plane/plane.gd"

var laser_beam
var laser_tip_label

func _ready() -> void:
	plane_velocity=120
	fire_cyc=2.5
	laser_beam=$LaserBeam2D
	laser_tip_label=$"CanvasLayer/武器提示"
	laser_tip_label.text="可以发射"
	
	fire_Timer.wait_time=fire_cyc
	fire_Timer.one_shot=true

#功能函数
var is_firing : bool = false

func fire() -> void: #开火
	if  not is_firing: 

		if not is_game_over and Input.is_action_pressed("fire") and is_ok_to_fire:
			
			laser_tip_label.text="激光充能中"
			is_firing=true
			is_ok_to_fire=false
			
			laser_beam.is_casting=true
			
			
			await get_tree().create_timer(0.8).timeout
			laser_beam.is_casting=false
			fire_Timer.start()
			is_firing=false
			
			
func _on_fire_timer_timeout() -> void: #这个是开火计时器的信号函数
	super._on_fire_timer_timeout()
	laser_tip_label.text="可以发射"
