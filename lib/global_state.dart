class Global_State {
  int navigation_bar_index = 0;
  List cat_list = [];
  List adopted_cat_list = [];
  List posted_cat_list = [];
  double latitude;
  double longitude;
  int selected_index;
  //only 1 user
  List user_list = [];
  String password = null;
  String value = "0";
  String catid = null;

  static Global_State instance = Global_State._();
  Global_State._();
}
