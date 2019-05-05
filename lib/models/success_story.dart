class SuccessStory {
  int userId;
  int id;
  String bodyJson;
  DateTime createdAt;

  SuccessStory({
    this.userId,
    this.id,
    this.bodyJson,
    this.createdAt
  });

  factory SuccessStory.fromJson(Map<String, dynamic> json) => new SuccessStory(
    userId: json["user_id"],
    id: json["id"],
    bodyJson: json["body_json"],
    createdAt: DateTime.parse(json["created_at"])
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "id": id,
    "bodyJson": bodyJson,
    "created_at": createdAt
  };
}