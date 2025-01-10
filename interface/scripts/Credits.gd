extends Control

onready var color_rect : ColorRect = $ColorRect
onready var main_container = $MainContainer
onready var static_text : Label = $MainContainer/VContainer/CreatorContainer/Label  # Texte statique séparé
onready var label1 : Label = $MainContainer/VContainer/CreatorContainer/Label2  # Deuxième texte
onready var another_label : Label = $Label3  # Texte à afficher
onready var button : Button = $Button  # Bouton
onready var tween : Tween = $Tween
onready var master_bus = AudioServer.get_bus_index("Master")

var button_pressed = false  # Variable pour suivre l'état du bouton

func _unhandled_input(event):
	if event.is_action_pressed("escape"):
		if button_pressed:  # Si le bouton a été pressé, cacher tous les éléments
			hide()
			tween.stop_all()
			static_text.hide()
			label1.hide()
			another_label.hide()
		else:  # Si le bouton n'a pas été pressé, comportement normal
			hide()
			tween.stop_all()

func start_credits():
	tween.reset_all()
	show()
	# Animer l'opacité du ColorRect
	tween.interpolate_property(color_rect, "modulate:a", 0.0, 0.9, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_completed(object, _key):
	if object == color_rect:
		if color_rect.modulate.a >= 0.5:
			# Animer uniquement main_container, sans affecter le texte statique
			tween.interpolate_property(main_container, "rect_position", main_container.rect_position, Vector2(0.0, -1500), 25.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
		else:
			hide()
	elif object == main_container:
		# Rendre le ColorRect transparent
		tween.interpolate_property(color_rect, "modulate:a", 0.9, 0.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_Button_pressed():
	button_pressed = true
	button.hide()
	static_text.hide()
	label1.hide()
	another_label.show()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Musique"), true)
	var audio_player: AudioStreamPlayer = $AudioStreamPlayer
	if audio_player:
		audio_player.play()
