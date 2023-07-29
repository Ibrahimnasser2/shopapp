
import 'package:review/models/home_data_model.dart';

import '../../../models/catogeries_model.dart';
import '../../../models/change favorites model.dart';
import '../../../models/favorites model.dart';

abstract class home_states {}

class home_intial_state extends home_states{}

class product_loading_data_state extends home_states{}
class  product_success_data_state extends home_states{
  home_model? homemodel;
  product_success_data_state(this.homemodel);
}

class product_fail_data_state extends home_states{
  final String error;

  product_fail_data_state(this.error);
}


class fav_loading_data_state extends home_states{}
class  fav_success_data_state extends home_states{
  FavoritesModel?Favorites_Model;
  fav_success_data_state(this.Favorites_Model);
}

class fav_fail_data_state extends home_states{
  final String error;

  fav_fail_data_state(this.error);
}



class changehome_state extends home_states {}

class succ_changefavor_state extends home_states {}
class succ_changefavor_state2 extends home_states {
  change_fav? change_favmodel;
  succ_changefavor_state2(this.change_favmodel);
}
class fail_changefavor_state extends home_states {

}


class categorie_loading_data_state extends home_states{}
class  categorie_success_data_state extends home_states{
  categories_model? categoriesmodel;
  categorie_success_data_state(this.categoriesmodel);
}

class categorie_fail_state extends home_states{
  final String error;

  categorie_fail_state(this.error);
}