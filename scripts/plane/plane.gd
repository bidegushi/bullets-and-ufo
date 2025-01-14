extends CharacterBody2D

@export var plane_velocity : float = 100
@export var bullet_scene : PackedScene
@export var fire_Timer : Timer

var fire_cyc : float = 0.2
var is_ok_to_fire : bool = true #是否可以开火 用于控制开火频率
var is_game_over : bool = false #是否已经被击败

func _ready() -> void:
	fire_Timer.wait_time=fire_cyc
	

func _process(delta: float) -> void:
	game_over_func()
	
func _physics_process(delta: float) -> void:
		move()
		fire()

#功能函数
func fire() -> void: #开火
	if Input.is_action_pressed("fire") and is_ok_to_fire:
		var bullet_node = bullet_scene.instantiate() 
		bullet_node.position=position+Vector2(0,-11)
		get_tree().current_scene.add_child(bullet_node)
		is_ok_to_fire=false
		fire_Timer.start()

func move() -> void: #移动
		if not is_game_over:
			#控制移动
			var direction : float = 0
			if Input.is_action_pressed("left"):
				direction -= 1
			if Input.is_action_pressed("right"):
				direction += 1
			velocity.x=direction*plane_velocity
			move_and_slide()#必须使用move_and_slide() 如果直接更改direction，就不会被碰撞影响

var game_over_check:bool=false #一次性的 检测游戏结束的流程是否已经开始
func game_over_func() -> void:
		if is_game_over and not game_over_check:
			game_over_check=true
			visible=false
			Global.create_explosion_with_255_rgb(position, 189, 195, 199 ,1)
			#await get_tree().create_timer(0.5).timeout
	
func _on_fire_timer_timeout() -> void: #这个是开火计时器的信号函数
	is_ok_to_fire = true
