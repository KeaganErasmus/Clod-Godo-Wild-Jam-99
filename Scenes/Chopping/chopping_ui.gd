class_name ChopUI
extends CanvasLayer

@onready var label = $MarginContainer/TChoppedLabel
@onready var flavour_text_label = $FlavourTextLabel

var trees_chopped : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_label_text("Trees Chopped: ")
	set_flavour_text("")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	set_label_text("Trees Chopped: " + str(trees_chopped) + "/" + str(Global.tree_quota))

func set_label_text(text: String):
	label.text = text

func set_trees_chopped(num: int):
	trees_chopped = num

func set_flavour_text(text: String) -> void:
	flavour_text_label.text = text
