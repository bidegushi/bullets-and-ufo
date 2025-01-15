extends Area2D

@export var ufo_speed : float = 100
@export var sprite : Sprite2D
@export var explosion_scene : PackedScene



var is_dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	#向下移动
	position.y+=ufo_speed*delta
	
	#超出可见范围即销毁
	
	if position.y>Global.down_boundary:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if not is_dead and area.is_in_group("player_bullet"): #如果碰到了玩家的子弹
		sprite.visible=false #消失
		Global.create_explosion_with_255_rgb(position,255,191,0,1) #播放爆炸效果
		is_dead=true #调整变量
		#area.queue_free() #删除子弹
		area.contact_enemy()
		get_tree().current_scene.score+=get_tree().current_scene.ufo_score#玩家加分
		
		await get_tree().create_timer(0.5).timeout #0.5秒后删除 同时爆炸效果也没了
		queue_free()
		


func _on_body_entered(body: Node2D) -> void:
	if not is_dead and body is CharacterBody2D:
		get_tree().current_scene.is_game_over=true
		
