extends Area3D
const win_condition = 3
const R_SPEED =2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func rotar_moneda():
	rotate_y(deg_to_rad(R_SPEED))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotar_moneda()
#	if  has_overlapping_bodies():
#		queue_free()


func _on_body_entered(body: Node3D) -> void:
	Global.coins+=1
	print(Global.coins)
	if Global.coins>= win_condition:
		print('ganaste vuelve a empezar')
		get_tree().change_scene_to_file("res://nivel_1.tscn")
	queue_free()
