class MessageChat {
  String? idSender;
  String? content;
  String? idReceiver;
  String? dateMessage;
  bool isMe;

  MessageChat({
    this.idSender,
    this.content,
    this.idReceiver,
    this.dateMessage,
    required this.isMe
  });

  factory MessageChat.fromJson(Map<String, dynamic> json) {
    return MessageChat(
      isMe: json["isMe"],
      idSender: json['idSender'],
      content: json['content'],
      idReceiver: json['idReceiver'],
      dateMessage: json['dateMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isMe': isMe,
      'idSender': idSender,
      'content': content,
      'idReceiver': idReceiver,
      'dateMessage': dateMessage
    };
  }
}
