extends Node2D

const REST_SCALE := Vector2.ONE
const HOVER_SCALE := Vector2(1.1, 1.1)
const SQUASH_SCALE := Vector2(1.15, 0.9)

const SQUASH_TIME := 0.1
const HOVER_TIME := 0.2

func _ready():
	MusicPlayer._play_button_click()
	var _tween: Tween = null
	_tween = create_tween()
	
	_tween.tween_property(self, ^"scale", HOVER_SCALE, HOVER_TIME).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	_tween.tween_property(self, ^"scale", REST_SCALE, HOVER_TIME).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
