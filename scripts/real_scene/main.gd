extends Node2D

#计时器
@export var ufo_generate_timer : Timer
@export var skeleton_generate_timer : Timer

#敌人场景
@export var ufo_scene : PackedScene
@export var skeleton_scene : PackedScene

#计分板场景
@export var scoreboard : PackedScene

#@export var back_scene : PackedScene #点击返回按钮回到的页面

var is_game_over : bool = false #游戏是否结束

var plane_node 
#var plane_scene=load("res://scene/plane/plane.tscn")
var plane_scene=Global.plane_scene

var score : int = 0 #游戏得分


#单个敌人消灭得分
var ufo_score : int = 1
var skeleton_score : int = 3

#敌人初始出现周期
var ufo_cyc : float = 2
var skeleton_cyc : float = 5

#当前模式
var mode : int = 0

#本局花费时间 单位秒 
#通过 _on_cost_time_timer_timeout() 实现计时
var cost_time : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/score_label/game_over.visible=false #初始状态下 游戏结束相关的不可见
	#plane_node=$Plane
	
	
	plane_node=plane_scene.instantiate()
	plane_node.position=Vector2(0,121)
	get_tree().current_scene.add_child(plane_node)
	

	
	ufo_generate_timer.wait_time=ufo_cyc #ufo出现周期
	skeleton_generate_timer.wait_time=skeleton_cyc #skeleton出现周期

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$CanvasLayer/score_label.text="分数: "+str(score) #实时更新分数显示
	
	
	
	#调整生成UFO的速度
	ufo_generate_timer.wait_time -= 0.1 * delta
	ufo_generate_timer.wait_time=clamp(ufo_generate_timer.wait_time,1,ufo_cyc)
	
	#调整生成skeleton的速度
	skeleton_generate_timer.wait_time -= 0.05 * delta
	skeleton_generate_timer.wait_time=clamp(skeleton_generate_timer.wait_time,2,skeleton_cyc)
	
	
	
	if is_game_over : #判断是否已经被击败了
		$Plane.is_game_over=true
		game_over() #执行main的game_over函数
	
var game_over_check:bool=false #是否已经执行游戏结束程序
func game_over() -> void :
	if not game_over_check:
		game_over_check=true
		#$CanvasLayer/score_label/game_over/final_score.text="最终分数: "+str(score) #显示最终分数
		#$CanvasLayer/score_label/game_over.visible=true #显示游戏结束的UI
		#$CanvasLayer/retry_and_back_button.visible=true
		#控制敌人生成的计时器停止计时
		ufo_generate_timer.stop()
		skeleton_generate_timer.stop()
		
		var scoreboard_node=scoreboard.instantiate()
		$CanvasLayer.add_child(scoreboard_node)



#生成ufo
func _on_ufo_generate_timer_timeout() -> void:
	var ufo_node = ufo_scene.instantiate()
	ufo_node.position=Vector2(randf_range(-200,200),-195)
	get_tree().current_scene.add_child(ufo_node)
	
#生成skeleton
func _on_skeleton_generate_timer_timeout() -> void:
	var skeleton_node = skeleton_scene.instantiate()
	skeleton_node.position=Vector2(randf_range(-230,230),randf_range(-80,-144))
	get_tree().current_scene.add_child(skeleton_node)




func _on_cost_time_timer_timeout() -> void:
	#这个计时器计时周期为1秒 结束后自动重启
	#用于实现正计时
	cost_time+=1
