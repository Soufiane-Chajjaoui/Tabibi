class UserChat {
  String? id;
  String? username;
  String? imageUrl;
  String? lastTime;

  UserChat({
    this.id,
    this.username,
    this.imageUrl,
    this.lastTime,
  });
  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        id: json["_id"],
        username: json["complete_name"],
        lastTime: json["lastTime"],
        imageUrl: json["avatar"]["url"],
      );
}
