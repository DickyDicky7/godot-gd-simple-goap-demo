@tool
extends EditorPlugin;

#var          plugin;

func _enter_tree() -> void:
	add_custom_type("Npc"                                      , "Node", preload("res://addons/godot_gd_simple_goap/npc.gd"                                                                                                                                                                                              ), preload("res://addons/godot_gd_simple_goap/Node.svg"));
	add_custom_type(    "NpcState"                             , "Node", preload(                                         "res://addons/godot_gd_simple_goap/npc_state.gd"                                                                                                                                               ), preload("res://addons/godot_gd_simple_goap/Node.svg"));
	add_custom_type(             "NpcGoal"                     , "Node", preload(                                                                                        "res://addons/godot_gd_simple_goap/npc_goal.gd"                                                                                                 ), preload("res://addons/godot_gd_simple_goap/Node.svg"));
	add_custom_type(                     "NpcAction"           , "Node", preload(                                                                                                                                      "res://addons/godot_gd_simple_goap/npc_action.gd"                                                 ), preload("res://addons/godot_gd_simple_goap/Node.svg"));
	add_custom_type(                               "NpcPlanner", "Node", preload(                                                                                                                                                                                      "res://addons/godot_gd_simple_goap/npc_planner.gd"), preload("res://addons/godot_gd_simple_goap/Node.svg"));
#	plugin = preload("res://addons/godot_gd_simple_goap/npc_inspector_plugin.gd").new();
#	add_inspector_plugin(
#				  plugin);
	pass;


func _exit_tree() -> void:
	remove_custom_type("Npc"                                      );
	remove_custom_type(    "NpcState"                             );
	remove_custom_type(             "NpcGoal"                     );
	remove_custom_type(                     "NpcAction"           );
	remove_custom_type(                               "NpcPlanner");
#	remove_inspector_plugin(
#					 plugin);
	pass;

#
#
