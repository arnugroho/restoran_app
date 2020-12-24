import 'package:restoran_app_dicoding/data/model/name_value.dart';

class Menus {
  List<NameValue> foods;
  List<NameValue> drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> menus) {
    foods = menus['foods'].map<NameValue>((json) => NameValue.fromJson(json)).toList();
    drinks = menus['drinks'].map<NameValue>((json) => NameValue.fromJson(json)).toList();
  }
}
