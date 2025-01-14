extends Area2D

var is_dead : bool
@export var skeleton_speed : float = 100
@export var sprite : Sprite2D
@export var explosion_scene : PackedScene
@export var bullet_scene : PackedScene
@export var fire_timer : Timer

var fire_cyc : float = 2 

var direction : float = 1 #方向

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction= -1 if randi() % 2 == 0  else 1 #初始方向
	fire_timer.wait_time=fire_cyc


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	position.x+=direction*skeleton_speed*delta
	if position.x<-250 or position.x>250 :
		direction*=-1
	
		
	


func _on_area_entered(area: Area2D) -> void:
		if not is_dead and area.is_in_group("player_bullet"): #如果碰到了玩家的子弹
			sprite.visible=false #消失
			Global.create_explosion_with_255_rgb(position, 177, 233, 169 ,1) #播放爆炸效果
			is_dead=true #调整变量
			area.queue_free() #删除子弹
			get_tree().current_scene.score+=get_tree().current_scene.skeleton_score#玩家加分
			
			await get_tree().create_timer(0.5).timeout #0.5秒后删除 同时爆炸效果也没了
			queue_free()


func _on_fire_timer_timeout() -> void:
	var bullet_node=bullet_scene.instantiate()
	bullet_node.position=position
	get_tree().current_scene.add_child(bullet_node)
	
	
