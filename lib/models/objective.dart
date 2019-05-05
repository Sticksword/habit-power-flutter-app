class Objective {
  int userId;
  int id;
  String title;
  int state;
  int score;
  int length;
  String description;
  DateTime createdAt;

  Objective({
    this.userId,
    this.id,
    this.title,
    this.state,
    this.score,
    this.length,
    this.description,
    this.createdAt
  });

  factory Objective.fromJson(Map<String, dynamic> json) => new Objective(
    userId: json["user_id"],
    id: json["id"],
    title: json["title"],
    state: json["state"],
    score: json["score"],
    length: json["length"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"])
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "id": id,
    "title": title,
    "state": state,
    "score": score,
    "length": length,
    "description": description,
    "created_at": createdAt
  };
}