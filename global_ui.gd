extends CanvasLayer

@onready var quota_label = $Control/QuotaLabel
@onready var time_left_bar = $Control/TimeLeft
@onready var day_count_label = $Control/DayLabel

var quota_label_text = "TODAY'S QUOTA: "
var data_centers_left: int

func _ready():
	day_count_label.text = "DAY: " + str(Global.days_elapsed)
	data_centers_left = Global.data_center_quota - Global.data_center_count
	quota_label.text = quota_label_text + str(data_centers_left) + " LEFT"
	time_left_bar.max_value = Global.max_time_left
	time_left_bar.min_value = 0

func _process(delta: float) -> void:
	data_centers_left = Global.data_center_quota - Global.data_center_count
	quota_label.text = quota_label_text + str(data_centers_left) + " LEFT"
	time_left_bar.value = Global.current_time_left
