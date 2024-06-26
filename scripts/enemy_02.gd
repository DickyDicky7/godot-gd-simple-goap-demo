extends Enemy;

func      _ready():
	super._ready();
	position = Vector2(get_viewport().size / 2) + Vector2(+100, 0);
	pos      =             position                              ;
	$Npc/Logger.debugger_window.title += " Enemy 02 ";
	pass;

func      _process(_delta):
	super._process(_delta);
	create_tween().tween_property(self, "position", pos, $AnimationPlayer.get_animation("MOVE").length).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART);
	pass;
