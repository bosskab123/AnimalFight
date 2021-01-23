extends RigidBody

var hp = 100

func _ready():
	
	pass
	
func health_decrease(damage):
	hp = hp - damage
	if hp <= 0:
		hp = 0
		print("I'm dead")
		queue_free()
	
	print("enemy hp: ", hp)
	
