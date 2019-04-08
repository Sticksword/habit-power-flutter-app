class User {
  int id;
  String firstName;
  String lastName;
  DateTime dob;
  String occupation;
  String about;
  String school;
  String company;
  DateTime createdAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.dob,
    this.occupation,
    this.about,
    this.school,
    this.company,
    this.createdAt
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    dob: DateTime.parse(json["date_of_birth"]),
    occupation: json["occupation"],
    about: json["about"],
    school: json["school"],
    company: json["company"],
    createdAt: DateTime.parse(json["created_at"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}