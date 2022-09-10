class PeopleModel {
  String? name;
  String? email;
  PeopleModel({this.email, this.name});
  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      email: json['email'],
      name: json['name'],
    );
  }
}
