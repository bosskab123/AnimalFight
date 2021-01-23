extends RigidBody

var max_health = 100
var current_health = max_health

onready var health_bar = $HealthBar3D/Viewport/HealthBar2D

func _ready():
	pass 
	
func health_decrease(amount):
	current_health = current_health - amount
	if current_health <= 0:
		print(self.name," die")
		queue_free()
	if current_health > 0:
		health_bar.update_bar(current_health,max_health)
		print(self.name,": ",current_health)
