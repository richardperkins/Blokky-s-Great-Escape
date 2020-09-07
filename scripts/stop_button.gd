extends ToolButton


export(Texture) var icon_disabled
export(Texture) var icon_enabled

var enabled = false


func is_button_enabled():
	return enabled

func set_button_enabled(val):
	enabled = val
	if enabled:
		icon = icon_enabled
	else:
		icon = icon_disabled

func toggle_button_enabled():
	set_button_enabled(not enabled)


func _on_Stop_Button_pressed():
	if enabled:
		get_tree().get_root().get_child(0).stop()


