class UserCredential {
  int userId;
  String authToken;
  String email;

  UserCredential({
    this.userId,
    this.authToken,
    this.email
  });

  factory UserCredential.fromJson(Map<String, dynamic> json, email) => new UserCredential(
    userId: json["id"],
    authToken: json["auth_token"],
    email: email
  );

  factory UserCredential.dbMap(dynamic obj) => new UserCredential(
    userId: obj["user_id"],
    authToken: obj["auth_token"],
    email: obj["email"]
  );

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["user_id"] = userId;
    map["email"] = email;
    map["auth_token"] = authToken;

    return map;
  }
}