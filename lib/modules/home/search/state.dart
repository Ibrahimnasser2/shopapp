abstract class search_states {}

class search_intial_state extends search_states{}

class loading_search_data_state extends search_states {}
class sucess_get_search_data_state extends search_states {}
class fail_get_search_data_state extends search_states {
  late final String error;
  fail_get_search_data_state(error);

}