extends DialogBody

onready var camera_slider: HSlider = $CameraContainer/HBoxContainer/CameraSlider
onready var camera_label: Label = $CameraContainer/HBoxContainer/CameraLabel
onready var audio_slider: HSlider = $VolumeContainer/HBoxContainer/AudioSlider
onready var audio_label: Label = $VolumeContainer/HBoxContainer/AudioLabel
onready var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	camera_slider.min_value = GameSettings.get_min_sensitivity()
	camera_slider.max_value = GameSettings.get_max_sensitivity()
	camera_slider.value = GameSettings.get_current_sensitivity()
	camera_label.text = str(stepify(GameSettings.get_current_sensitivity(),0.01))
	audio_slider.value = AudioServer.get_bus_volume_db(master_bus)

func confirm_pressed():
	GameSettings.set_current_sensitivity(camera_slider.value)
	.confirm_pressed()

func _on_CameraSlider_value_changed(value):
	camera_label.text = str(stepify(value,0.01))

func _on_AudioSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value <= -30:
		AudioServer.set_bus_mute(master_bus, true)
		audio_label.text = "0%"
	else:
		AudioServer.set_bus_mute(master_bus, false)
		# Calculer le pourcentage basé sur la plage de -30 à 0 dB
		var percentage = int((value + 30) / 30.0 * 100)
		audio_label.text = str(percentage) + "%"
