extends Node
	
func wait_x_seconds(timer: float) -> void:
	await get_tree().create_timer(timer)
	print("Timer finished!")
