extends Control



class ScoreStruct:
	var mode:int #游戏的模式
	var player_name:String #玩家留名
	var time:String #时间 YYYY-MM-DDTHH:MM:SS
	var cost_time:int #本局游戏的时间 单位为秒 保留整数
	var score:int #本局游戏得分
	
#get_datetime_string_from_unix_time

#存储分数文件的位置
var file_path : String = "G:/godot/project/project0/test/score.csv"


var scoreboard #显示分数榜的位置
var score_show #显示分数的位置
var cost_time_show #显示花费时间的位置
var player_name_in #输入玩家名的地方

#本局的数据
var mode:int #游戏的模式
var player_name:String #玩家留名
var time:String #时间 YYYY-MM-DDTHH:MM:SS
var cost_time:int #本局游戏的时间 单位为秒
var score:int #本局游戏得分



func _ready() -> void:
	score_show=$"ColorRect/文字_本轮得分/分数"
	scoreboard=$"ColorRect/前10显示"
	cost_time_show=$"ColorRect/文字_本轮用时/用时"
	player_name_in=$"ColorRect/分数输入的下矩形/player_name_in"
	
	
	
	mode=get_tree().current_scene.mode
	time=Time.get_datetime_string_from_system()
	score=get_tree().current_scene.score
	print("now score = %d"%score)
	cost_time=get_tree().current_scene.cost_time
	print(score_show)
	
	
	score_show.text="%d"%score
	cost_time_show.text=cost_time_to_string(cost_time)
	
	
	show_top10()
	
	
func show_top10() -> void:
	
	var arr=get_top_scores_from_csv(file_path)
	var print_str=""
	var cnt=0
	for item in arr:
		var cost_time_string=cost_time_to_string(item.cost_time)
		cnt+=1
		#var str_line="{}                  {}             {}            {}\n".format(["%2d"%cnt,cost_time_string,item.score,item.player_name])
		var str_line="%2d                  "%cnt + "%s             "%cost_time_string + "%d              "%item.score+"%s"%item.player_name
		print_str+=str_line
	scoreboard.text=print_str

# 将 ScoreStruct 数据保存到 CSV 文件中
func save_score_to_csv(filename: String, score_data: ScoreStruct):
	var file = FileAccess.open(filename, FileAccess.READ_WRITE)

	if file == null:
		print("无法打开文件")
		return

	# 如果文件为空，写入表头（只在第一次写入时添加）
	#if file.get_len() == 0:
	#	file.store_line("mode,name,time,cost_time,score")  # 表头
	
	file.seek_end()
	
	# 写入数据行
	var line = str(score_data.mode) + "," + score_data.player_name + "," + score_data.time + "," + str(score_data.cost_time) + "," + str(score_data.score)
	file.store_line(line)

	file.close()
	print("数据已保存到 CSV 文件:", filename)


# 从 CSV 文件中读取数据并返回得分前 10 的记录
func get_top_scores_from_csv(filename: String) -> Array:
	var file = FileAccess.open(filename, FileAccess.READ)
	
	if file == null:
		print("无法打开文件")
		return []
	
	var scores = []
	
	# 跳过文件的第一行（表头）
	#file.get_line()
	
	# 读取每一行数据并解析
	while not file.eof_reached():
		var line = file.get_line().strip_edges()
		if line != "":
			var columns = line.split(",")
			
			# 创建一个 ScoreStruct 对象并填充数据
			var score_entry = ScoreStruct.new()
			score_entry.mode = int(columns[0])
			score_entry.player_name = columns[1]
			score_entry.time = columns[2]
			score_entry.cost_time = float(columns[3])
			score_entry.score = int(columns[4])

			# 将每个分数记录添加到数组中
			if score_entry.mode==mode: #如果是同一模式的 就计入
				scores.append(score_entry)
	
	file.close()

	# 按照分数排序（降序）
	scores.sort_custom(_sort_by_score)

	# 返回前 10 个得分
	return scores.slice(0, 10)

# 排序函数：根据得分排序
func _sort_by_score(a, b):
	return b.score - a.score  # 降序排序
	

func cost_time_to_string(cost_time : int) -> String :
	var s
	var m
	m=cost_time/60
	s=cost_time%60
	return "%2d"%m + ":%2d"%s
	
	
	

var has_saved : bool = false
func _on_submit_button_pressed() -> void:
	
	
	if not has_saved:
		has_saved=true
		player_name=player_name_in.text

		var latest_score = ScoreStruct.new()
		latest_score.mode = mode
		latest_score.player_name = player_name
		latest_score.time = time
		latest_score.cost_time = cost_time
		latest_score.score = score

		save_score_to_csv(file_path,latest_score)

		show_top10() #刷新分数榜
	
	



func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_back_button_pressed() -> void:
	SceneManager.change_scene("start_page")
