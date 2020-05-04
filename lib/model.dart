class Model {
  String id;
  String firstName;
  String lastName;

  Model({this.id, this.firstName, this.lastName});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }
}
