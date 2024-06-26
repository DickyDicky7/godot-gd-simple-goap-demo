class_name  NpcGoal;
extends        Node;

@export_group("Data")
@export var          goal_name       : StringName      ;
@export var priority                 : float      = 0.0;
"""
@export var desired_state_collection : Dictionary      ;
"""
@export var desired_expression_collection:Array[CustomExpression];

@export_group("References")
@export var    npc_state : NpcState;

"""
func is_desired_state_collection_met() -> bool:
	if (       npc_state == null     )        :
		return true;
	else:
		return npc_state.is_required_state_collection_met(
							 desired_state_collection    );
"""

func is_desired_expression_collection_met (                           ) -> bool:
	var result : bool = true;
	for custom_expression : CustomExpression in desired_expression_collection:
		var    expression :       Expression =          Expression.new()     ;
		expression.parse(
 custom_expression.expression
,custom_expression.parameters);
		var expression_values : Array = [];
		for parameter : StringName in custom_expression.parameters:
			expression_values.push_back(      npc_state.     state_collection[parameter]);
		result =                       (
		result &&  expression. execute(
			expression_values, self   ))  ;
	return result;

func is_desired_expression_collection_met_(state_collection:Dictionary) -> bool:
	var result : bool = true;
	for custom_expression : CustomExpression in desired_expression_collection:
		var    expression :       Expression =          Expression.new()     ;
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

func _get_dynamic_priority() -> float:
	return 0.0;

func  get_totally_priority() -> float:
	return        priority 
	+_get_dynamic_priority()         ;
