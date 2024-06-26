class_name NpcPlanner;
extends          Node;

@export_group("References")
@export var npc_goals   : Array[NpcGoal  ];
@export var npc_actions : Array[NpcAction];

# using common greedy algorithm
func   plan1()                                         ->       NpcAction:
	var                     valid_npc_action_collection : Array[NpcAction];
	for     npc_action in         npc_actions           :
		if (npc_action.is_precondition_expression_collection_met()) :
							valid_npc_action_collection.append(
			npc_action                                        );
			
	var     chosen_npc_goal : NpcGoal = null ;
	for            npc_goal in     npc_goals :
		if (       npc_goal.is_desired_expression_collection_met()):
			continue;
		if (chosen_npc_goal == null
		or         npc_goal.get_totally_priority()
		 >  chosen_npc_goal.get_totally_priority()           ):
			chosen_npc_goal =  npc_goal ;
	
	if     (chosen_npc_goal == null    ):
		return null;
	
	var            best_npc_action =      null;
	if (not chosen_npc_goal.is_desired_expression_collection_met()):
		var   cost_npc_lowest      =                    INF   ;
		for        npc_action                               in   valid_npc_action_collection       :
			if (   npc_action                              .is_precondition_expression_collection_met()):
				var      npc_action_total_cost = npc_action.            get_total_cost          () ;
				if (best_npc_action ==    null
				or       npc_action_total_cost
				<   cost_npc_lowest           ):
					best_npc_action =            npc_action;
					cost_npc_lowest =            npc_action_total_cost;
					
	return          best_npc_action ;

@export_group("References")
@export var npc_planning_ahead_max_depth : int = 3;

# using simplified version of a depth-limited-search + back-tracking algorithm
func plan2()     ->        NpcAction:
	var best_action      : NpcAction = null;
	var best_action_score: float     = -INF;
	
	for action : NpcAction  in        npc_actions          :
		if (
		action.is_precondition_expression_collection_met()):
			var action_score : float =      evaluate_action2(action, 0);
			
			if (action_score > best_action_score):
				best_action       = action       ;
				best_action_score = action_score ;

	return      best_action                      ;

func evaluate_action2(action: NpcAction, depth: int) -> float:
	if (depth >=  npc_planning_ahead_max_depth
	or  not 
		action.is_precondition_expression_collection_met())  :
		return                                            (  -
		action.                       get_total_cost    ())  ;  
	
	var total_score: float = 0.0;
	
	action.   apply_post_action_expresion_collection();
	
	for goal        : NpcGoal    in npc_goals  :
		if (          not  goal. is_desired_expression_collection_met()):
			total_score += goal.get_totally_priority();
	
	for next_action : NpcAction  in npc_actions:
			total_score +=    evaluate_action2(
		next_action , depth + 1               );
	
	action. unapply_post_action_expresion_collection();
	
	return  total_score                        ;

"""
# using simplified version of a depth-limited search algorithm - another implementation
func plan3()       ->              NpcAction:
	var best_sequence      : Array[NpcAction] = [  ];
	var best_sequence_score: float            = -INF;
	
	for action    in                        npc_actions:
		var  sequence      : Array[NpcAction] = [action]                       ;
		var  sequence_score: float            = evaluate_sequence3(sequence, 1);
		
		if (     sequence_score >
			best_sequence_score):
			best_sequence       = sequence      ;
			best_sequence_score = sequence_score;
	
	if     (   best_sequence.size() > 0):
		return best_sequence         [0];
	else:
		return null                     ;

func evaluate_sequence3(sequence: Array[NpcAction], depth: int) -> float:
	if (                         depth
	>=    npc_planning_ahead_max_depth
	or                  sequence.size() == 0):
		return                    (
	   evaluate_goal_completion3()) ;
	
	var     total_score: float = 0.0;
	
	sequence[0].  apply_post_action_expresion_collection();
	
	total_score -=                    sequence[0]               .     get_total_cost();
	total_score += evaluate_sequence3(sequence.slice(1, sequence.size()), depth  +  1);
	
	sequence[0].unapply_post_action_expresion_collection();
	
	return  total_score;

func   evaluate_goal_completion3() -> float      :
	var     total_score             : float = 0.0;
	for         goal               in   npc_goals:
		if (not goal.is_desired_expression_collection_met()):
			total_score +=                                   goal.get_totally_priority();
	return  total_score                                                                 ;
"""
#
