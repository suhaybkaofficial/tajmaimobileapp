import 'dart:convert';

class MessageModel {
  final int id;
  final DateTime dateTime;
  final String text;
  final bool isMe;
  MessageModel({
    required this.id,
    required this.dateTime,
    required this.text,
    required this.isMe,
  });

  MessageModel copyWith({
    int? id,
    DateTime? dateTime,
    String? text,
    bool? isMe,
  }) {
    return MessageModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'dateTime': dateTime.millisecondsSinceEpoch});
    result.addAll({'text': text});
    result.addAll({'isMe': isMe});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id']?.toInt() ?? 0,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      text: map['text'] ?? '',
      isMe: map['isMe'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, dateTime: $dateTime, text: $text, isMe: $isMe)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.id == id &&
        other.dateTime == dateTime &&
        other.text == text &&
        other.isMe == isMe;
  }

  @override
  int get hashCode {
    return id.hashCode ^ dateTime.hashCode ^ text.hashCode ^ isMe.hashCode;
  }
}
