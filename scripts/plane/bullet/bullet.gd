extends Area2D

@export var bullet_speed : float = 180

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	
	#创建后一直向上移动 并且直接改变position 不考虑碰撞
	position.y += -bullet_speed * delta
	
	
	#自动销毁已经在屏幕外的子弹
	if position.y<-181:
		queue_free()
