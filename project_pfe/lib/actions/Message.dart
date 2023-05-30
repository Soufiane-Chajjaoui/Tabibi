class MessageChat {
  String? idSender;
  String? content;
  String? idReceiver;
  String? dateMessage;

  MessageChat({
    this.idSender,
    this.content,
    this.idReceiver,
    this.dateMessage,
  });

  factory MessageChat.fromJson(Map<String, dynamic> json) {
    return MessageChat(
      idSender: json['idSender'],
      content: json['content'],
      idReceiver: json['idReceiver'],
      dateMessage: json['dateMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idSender': idSender,
      'content': content,
      'idReceiver': idReceiver,
    };
  }
}
