extends NpcAction;

@export var npc : Npc;

func      _perform() -> void :
	super._perform()         ;
	npc.queue_free();
	pass;

func             _get_dynamic_cost() -> float :
	return super._get_dynamic_cost()          ;
