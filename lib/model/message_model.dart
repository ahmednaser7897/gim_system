class MessageModel {
  String? userId;
  String? coachId;
  String? message;
  String? file;
  String? type;
  String? dateTime;
  String? id;

  MessageModel(
      {this.userId,
      this.coachId,
      this.message,
      this.dateTime,
      this.type,
      this.id,
      this.file});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId: json['userId'],
      coachId: json['coachId'],
      message: json['message'],
      dateTime: json['dateTime'],
      type: json['type'],
      id: json['id'],
      file: json['file'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'coachId': coachId,
      'message': message,
      'dateTime': dateTime,
      'type': type,
      'id': id,
      'file': file,
    };
  }
}
