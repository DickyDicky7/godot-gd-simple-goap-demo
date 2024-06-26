class_name NpcState;
extends        Node;

@export_group("Data")
@export var      state_collection : Dictionary ;

""" IGNORE
func is_required_state_collection_met         (
		required_state_collection : Dictionary) -> bool:
	for key in required_state_collection.keys():
		if (            state_collection.get     (key)
		!=     required_state_collection         [key]):
			return false;
	return true;
"""
#
#
#
#
