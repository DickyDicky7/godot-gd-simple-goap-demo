class_name Npc ;
extends    Node;

@export_group           ("References")
@export var npc_named   :  String   ;
@export var npc_state   : NpcState  ;
@export var npc_planner : NpcPlanner;
@export var    animation_player     : AnimationPlayer ;
@export var mode        :       MODE;
@export var              logger     :          Logger ;

enum MODE {   GREEDY                  ,
DEPTH_LIMITED_SEARCH_AND_BACK_TRACKING, };

var     current_npc_action          ;
func process1(delta: float) -> void :
	if       (animation_player != null
	and       animation_player.is_playing()):
		if   (animation_player.    get_animation(
			  animation_player.current_animation).loop_mode == Animation.LoopMode.LOOP_NONE):
			return;
	if       (
		current_npc_action  == null
	or not
		current_npc_action.is_precondition_expression_collection_met()             ):
		current_npc_action   =                                   npc_planner.plan1();
	else:
		if (animation_player!= null):
			animation_player.  play      (
		current_npc_action.animation_name);
		current_npc_action.perform                           ();
#		current_npc_action.apply_post_action_state_collection();

		if (logger != null):
			logger.log("<<<", Logger.LogLevel.DEBUG);
			if (current_npc_action != null):
				logger.log("NPC %s prev state: %s" % [npc_named, npc_state.state_collection]);
				logger.log("NPC %s perform action %s" % [npc_named, current_npc_action.action_name]);
				logger.log("NPC %s post state: %s" % [npc_named, npc_state.state_collection]);
#			if (current_npc_action == null):
#				logger.log("NPC %s perform nothin   " % [npc_named                                ]);
			logger.log(">>>", Logger.LogLevel.DEBUG);

	pass;

func process2(delta: float) -> void :
	if       (animation_player != null
	and       animation_player.is_playing()):
		if   (animation_player.    get_animation(
			  animation_player.current_animation).loop_mode == Animation.LoopMode.LOOP_NONE):
			return;

	if (    current_npc_action == null
	or not  current_npc_action.is_precondition_expression_collection_met()             ):
			current_npc_action =                                     npc_planner.plan2();

	if (    current_npc_action != null):
		if (animation_player   != null):
			animation_player  .          play(
			current_npc_action.animation_name);
		current_npc_action.perform();

		if (logger != null):
			logger.log("[[[", Logger.LogLevel.DEBUG);
			if (current_npc_action != null):
				logger.log("NPC %s prev state: %s" % [npc_named, npc_state.state_collection]);
				logger.log("NPC %s perform action %s" % [npc_named, current_npc_action.action_name]);
				logger.log("NPC %s post state: %s" % [npc_named, npc_state.state_collection]);
#			if (current_npc_action == null):
#				logger.log("NPC %s perform nothin   " % [npc_named                                ]);
			logger.log("]]]", Logger.LogLevel.DEBUG);

	pass;

func _process(delta: float) -> void :
	if (mode == MODE.              GREEDY                  ):
		process1(delta);
	if (mode == MODE.DEPTH_LIMITED_SEARCH_AND_BACK_TRACKING):
		process2(delta);
	pass;

#
#
#
#
#
#
#
#
