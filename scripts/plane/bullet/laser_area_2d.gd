extends Area2D

#因为其他子弹被敌人检测到后 会调用contact_enemy()来销毁
#以实现子弹碰到敌人不能穿透的效果
#但是这个激光不用 所以就pass
func contact_enemy():
	pass
