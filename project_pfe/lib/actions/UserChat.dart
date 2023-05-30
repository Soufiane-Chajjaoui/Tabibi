
class UserChat {
  String? id;
  String? username;
  String? imageUrl;
  bool? isOnline = false;
  String? lastTime;

  UserChat({
    this.id,
    this.username,
    this.imageUrl,
    this.isOnline,
    this.lastTime,
  });
  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        id: json["_id"],
        username: json["complete_name"],
        isOnline: json["isOnline"],
        lastTime: json["lastTime"],
        imageUrl: json["avatar"]["url"],
      );
}
