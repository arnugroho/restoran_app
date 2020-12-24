class NameValue {
  String name;

  NameValue({this.name});

  NameValue.fromJson(Map<String, dynamic> nameValue) {
    name = nameValue['name'];
  }
}
