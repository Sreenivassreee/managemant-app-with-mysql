class Model {
  String id;
  String firstName;
  String lastName;

  Model({this.id, this.firstName, this.lastName});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }
}
