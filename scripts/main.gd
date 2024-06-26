extends Node;

func _process(delta):
	get_window().title = str(Engine.get_frames_per_second());
	pass;
