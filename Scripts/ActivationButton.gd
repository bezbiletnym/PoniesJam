extends TextureButton
class_name InteractiveObject

@export var anim_player: AnimationPlayer
@export var isGoal: bool
@export var actions: Array[String]
@export var soundFile: Resource
@onready var sceneManager = get_node("/root/Room/SceneTransition") #Верхняя нода всех комнат и вступлений должна называться Room
@onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	if soundFile:
		audio.stream = soundFile


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	anim_player.play("hover")

func _on_mouse_exited():
	anim_player.play_backwards("hover")


func _on_pressed():	
	for action in actions:
		match action:
			"sound":
				await play_sound()

	if isGoal == true:
		sceneManager.transition_to()
	

func play_sound():
	if audio.stream: #check if the audiofile is loaded
		audio.play()
		await audio.finished
	else:
		print_debug("NO AUDIO")
