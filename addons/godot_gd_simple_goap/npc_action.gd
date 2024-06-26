class_name NpcAction;
extends         Node;

var prev_performed_timestamp: float = -INF;

@export_group ("Data")
## Action's name
@export var             action_name      : StringName;
"""
## Action's preconditions
@export var precondition_state_collection: Dictionary;
## Action's  post effects
@export var  post_action_state_collection: Dictionary;
"""
## Action's preconditions
@export var precondition_expression_collection: Array[CustomExpression];
## Action's  post effects
@export var  post_action_expression_collection: Array[CustomExpression];
## Action's  base cost
@export var       cost: float = 0.0;
@export var   cooldown: float = 0.0;
@export var   animation_name: StringName      ;
@export var   animation_wait_time: float = 0.0;

@export_group("References")
@export var npc_state: NpcState;

"""
# Temporarily deprecated
func              _is_precondition_state_collection_met () -> bool:
	return npc_state. is_required_state_collection_met (
				self.precondition_state_collection     );

# Temporarily deprecated
func            _apply_post_action_state_collection     () -> void:
	for key   in      post_action_state_collection.keys():
		if (npc_state.state_collection.has(key)):
			npc_state.state_collection    [key] =      (
					  post_action_state_collection[key]);
	pass;
"""

func              is_precondition_expression_collection_met (                      ) -> bool:
	var result : bool = true;
	for custom_expression : CustomExpression in precondition_expression_collection:
		var    expression :       Expression =               Expression.new()     ;
		expression.parse(
 custom_expression.expression
,custom_expression.parameters);
		var expression_values : Array = [];
		for parameter : StringName in custom_expression.parameters:
			expression_values.push_back(      npc_state.state_collection[parameter]);
		result =                       (
		result &&  expression. execute(
			expression_values, self   ))  ;
	return result;

func              is_precondition_expression_collection_met_(
														state_collection:Dictionary) -> bool:
	var result : bool = true;
	for custom_expression : CustomExpression in precondition_expression_collection:
		var    expression :       Expression =               Expression.new()     ;
		expression.parse(
 custom_expression.expression
,custom_expression.parameters);
		var expression_values : Array = [];
		for parameter : StringName in  custom_expression.parameters :
			expression_values.push_back(state_collection[parameter]);
		result =                       (
		result &&  expression. execute(
			expression_values, self   ))  ;
	return result;

var old_npc_state_state_collection_collection:   Array    [ Dictionary ] =[]     ;
func            apply_post_action_expresion_collection    (                           ) -> void:
	old_npc_state_state_collection_collection.push_back(
		npc_state.state_collection.duplicate( true )   );
	for custom_expression : CustomExpression in post_action_expression_collection:
		var    expression :       Expression =              Expression.new()     ;
		expression.parse(
 custom_expression.expression
,custom_expression.parameters);
		var expression_values : Array = [];
		for parameter : StringName in custom_expression.parameters    :
			expression_values.push_back(      npc_state.   state_collection[parameter]);
		### EXPERIMENT ###
		var m1 : PackedStringArray =  custom_expression.assigned_state.split(".") ;
		var m2 : Object            =          npc_state.   state_collection[m1[0]];
		var rv : Variant           =   (
			expression.execute    (
			expression_values,self)    );
		if (m1.size() <= 1):                  npc_state.   state_collection[
                                      custom_expression.assigned_state     ] = rv ;
		else:
			create_tween(
			     ).tween_property(m2, ":".join(m1.slice(1)), rv, 0);
		### EXPERIMENT ###
	pass;

func          unapply_post_action_expresion_collection    (                           ) -> void:
	if (                             old_npc_state_state_collection_collection.    size()> 0  ):
		npc_state.state_collection = old_npc_state_state_collection_collection.pop_back();
	pass;

func            apply_post_action_expresion_collection_   (state_collection:Dictionary) -> void:
	for custom_expression : CustomExpression in post_action_expression_collection:
		var    expression :       Expression =              Expression.new()     ;
		expression.parse(
 custom_expression.expression
,custom_expression.parameters);
		var expression_values : Array = [];
		for parameter : StringName in custom_expression.parameters   :
			expression_values.push_back(                   state_collection[parameter]);
		state_collection         [
 custom_expression.assigned_state]    =      expression.execute     (
											 expression_values, self);
	pass;

func     perform() -> void:
	if (is_ready()):
#		print(npc_state.state_collection)
		_perform() ;        marking_performed_timestamp();
		apply_post_action_expresion_collection         (); old_npc_state_state_collection_collection.clear();
#		print(npc_state.state_collection)
	else:
#		print("Action \"%s\" on cooldown" % self.action_name);
		pass;
	pass;

func    _perform() -> void:
	pass;

func _get_dynamic_cost() -> float:
	return 0.0;

func    get_total_cost() -> float:
	return        cost + _get_dynamic_cost();

func     is_ready               () -> bool:
	return                         Time.get_ticks_msec() / 1000.0 >= prev_performed_timestamp + cooldown;
	
func marking_performed_timestamp() -> void:
		prev_performed_timestamp = Time.get_ticks_msec() / 1000.0                                       ;
		pass                                                                                            ;

#
#
#
#
