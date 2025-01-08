extends Panel

onready var forward_label = $MarginContainer/VBoxContainer/VBoxContainer/ForwardLabel
onready var backwards_label = $MarginContainer/VBoxContainer/VBoxContainer/BackwardsLabel
onready var left_label = $MarginContainer/VBoxContainer/VBoxContainer/LeftLabel
onready var right_label = $MarginContainer/VBoxContainer/VBoxContainer/RightLabel
onready var jump_label = $MarginContainer/VBoxContainer/VBoxContainer2/JumpLabel
onready var sprint_label = $MarginContainer/VBoxContainer/VBoxContainer2/SprintLabel
onready var reload_label = $MarginContainer/VBoxContainer/VBoxContainer3/ReloadLabel
onready var melee_label = $MarginContainer/VBoxContainer/VBoxContainer3/MeleeLabel
onready var fire_label = $MarginContainer/VBoxContainer/VBoxContainer4/FireLabel
onready var aim_label = $MarginContainer/VBoxContainer/VBoxContainer4/AimLabel
onready var swap_label = $MarginContainer/VBoxContainer/VBoxContainer5/SwapLabel
onready var primary_label = $MarginContainer/VBoxContainer/VBoxContainer5/PrimaryLabel
onready var secondary_label = $MarginContainer/VBoxContainer/VBoxContainer5/SecondaryLabel
onready var score_label = $MarginContainer/VBoxContainer/VBoxContainer6/ScoreLabel
onready var sacrifice_label = $MarginContainer/VBoxContainer/VBoxContainer6/SacrificeLabel

const JOY_LEFT_STICK = "Joystick Gauche"
const JOY_SPRINT = "L3"
const JOY_MELEE = "R1"
const JOY_FIRE = "R2"
const JOY_AIM = "L2"
const JOY_SCORE = "L1"
const JOY_PRIMARY = "Flèche Gauche"
const JOY_SECONDARY = "Flèche Droite"
const KEY_FORWARD = "Z"
const KEY_LEFT = "Q"
const KEY_JUMP = "Barre d'espace"
const KEY_SPRINT = "Shift"
const KEY_RELOAD = "R ou I"
const KEY_MELEE = "E ou O"
const KEY_FIRE = "Clic gauche"
const KEY_AIM = "Clic droit"
const KEY_PRIMARY = "1 ou -"
const KEY_SECONDARY = "2 ou ="
const KEY_SCORE = "Capslock ou Entrée"
const KEY_SACRIFICE = "Retour arrière"
const PT_BACKWARDS = "S"
const EN_BACKWARDS = "S"
const PT_RIGHT = "D"
const EN_RIGHT = "D"
const PT_SWAP = "Tab ou ["
const EN_SWAP = "Tab ou ]"

func _ready():
	Input.connect("joy_connection_changed", self, "_on_gamepad_changed")
	update_commands()

func update_commands():
	if GameSettings.is_gamepad_mode():
		set_gamepad_commands()
	else:
		set_keyboard_commands()

func set_gamepad_commands():
	forward_label.text = "Avancer : %s" % JOY_LEFT_STICK
	backwards_label.text = "Reculer : %s" % JOY_LEFT_STICK
	left_label.text = "Gauche : %s" % JOY_LEFT_STICK
	right_label.text = "Droite : %s" % JOY_LEFT_STICK
	sprint_label.text = "Courir : %s" % JOY_SPRINT
	melee_label.text = "Mêlée : %s" % JOY_MELEE
	fire_label.text = "Tirer : %s" % JOY_FIRE
	aim_label.text = "Viser : %s" % JOY_AIM
	score_label.text = "Tableau des scores : %s" % JOY_SCORE
	reload_label.text = "Recharger : %s" % get_reload_button()
	jump_label.text = "Sauter : %s" % get_jump_button()
	swap_label.text = "Changer d'arme : %s" % get_swap_button()
	sacrifice_label.text = "Sacrifice : %s" % get_sacrifice_button()
	primary_label.text = "Équiper arme principale : %s" % JOY_PRIMARY
	secondary_label.text = "Équiper arme secondaire : %s" % JOY_SECONDARY

func set_keyboard_commands():
	forward_label.text = "Avancer : %s" % KEY_FORWARD
	left_label.text = "Gauche : %s" % KEY_LEFT
	sprint_label.text = "Courir : %s" % KEY_SPRINT
	jump_label.text = "Sauter : %s" % KEY_JUMP
	reload_label.text = "Recharger : %s" % KEY_RELOAD
	melee_label.text = "Mêlée : %s" % KEY_MELEE
	fire_label.text = "Tirer : %s" % KEY_FIRE
	aim_label.text = "Viser : %s" % KEY_AIM
	primary_label.text = "Équiper arme principale : %s" % KEY_PRIMARY
	secondary_label.text = "Équiper arme secondaire : %s" % KEY_SECONDARY
	score_label.text = "Tableau des scores : %s" % KEY_SCORE
	sacrifice_label.text = "Sacrifice : %s" % KEY_SACRIFICE
	if OS.keyboard_get_layout_language(OS.keyboard_get_current_layout()) == "pt":
		backwards_label.text = "Reculer : %s" % PT_BACKWARDS
		right_label.text = "Droite : %s" % PT_RIGHT
		swap_label.text = "Changer d'arme : %s" % PT_SWAP
	else:
		backwards_label.text = "Reculer : %s" % EN_BACKWARDS
		right_label.text = "Droite : %s" % EN_RIGHT
		swap_label.text = "Changer d'arme : %s" % EN_SWAP

func get_reload_button():
	match Input.get_joy_name(GameSettings.gamepad_id):
		"PS4 Controller":
			return "Carré"
		_:
			return "Croix"

func get_jump_button():
	match Input.get_joy_name(GameSettings.gamepad_id):
		"PS4 Controller":
			return "X"
		_:
			return "A"

func get_swap_button():
	match Input.get_joy_name(GameSettings.gamepad_id):
		"PS4 Controller":
			return "Triangle"
		_:
			return "Y"

func get_sacrifice_button():
	match Input.get_joy_name(GameSettings.gamepad_id):
		"PS4 Controller":
			return "Partager"
		_:
			return "Sélectionner"

func _on_gamepad_changed(_device_id, _connected):
	update_commands()

