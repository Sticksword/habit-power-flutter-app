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
  String username;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.dob,
    this.occupation,
    this.about,
    this.school,
    this.company,
    this.createdAt,
    this.username
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
    createdAt: DateTime.parse(json["created_at"]),
    username: json["username"]
  );

  // factory User.dbMap(dynamic obj) => new User(
  //   id: obj["id"],
  //   firstName: obj["first_name"],
  //   lastName: obj["last_name"],
  //   dob: DateTime.parse(obj["dob"]),
  //   occupation: obj["occupation"],
  //   about: obj["about"],
  //   school: obj["school"],
  //   company: obj["company"],
  //   createdAt: DateTime.parse(obj["created_at"]),
  //   username: obj["username"],
  //   authToken: obj["auth_token"]
  // );

  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   map["id"] = id;
  //   map["username"] = username;
  //   map["auth_token"] = authToken;
  //   map["first_name"] = firstName;
  //   map["last_name"] = lastName;
  //   map["dob"] = dob;
  //   map["occupation"] = occupation;
  //   map["about"] = about;
  //   map["school"] = school;
  //   map["company"] = company;
  //   map["created_at"] = createdAt;

  //   return map;
  // }
}