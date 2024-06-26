extends    Node2D       ;
class_name        Enemy ;

@export var     pos:                Vector2 ;
@export var     hrt: bool;
@export var     npc_state: NpcState;
@export var opposed_enemy:    Enemy;
@export var hp: int = 100;

func _ready():
	if (npc_state != null):
		npc_state.state_collection[ "iam" ] = self         ;
		npc_state.state_collection["enemy"] = opposed_enemy;
	pass;

func _process(_delta):
	$Visuals/Line2D.clear_points();
	for point in range(-hp/2.0, +hp/2.0):
			$Visuals/Line2D.add_point(Vector2(point, 10));
	if (	$Visuals/Line2D.points.size() >= 75):
			$Visuals/Line2D.default_color = Color.GREEN;
	elif (	$Visuals/Line2D.points.size() >= 50):
			$Visuals/Line2D.default_color = Color.YELLOW;
	elif (	$Visuals/Line2D.points.size() >= 25):
			$Visuals/Line2D.default_color = Color.ORANGE;
	else:
			$Visuals/Line2D.default_color = Color.RED;
	pass;
	
