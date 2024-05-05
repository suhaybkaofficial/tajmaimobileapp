import 'dart:convert';

class ChatListModel {
  final int id;
  final String image;
  final String name;
  final String msg;
  final String dateTime;
  final String numberOfMsg;
  ChatListModel({
    required this.id,
    required this.image,
    required this.name,
    required this.msg,
    required this.dateTime,
    required this.numberOfMsg,
  });

  ChatListModel copyWith({
    int? id,
    String? image,
    String? name,
    String? msg,
    String? dateTime,
    String? numberOfMsg,
  }) {
    return ChatListModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      msg: msg ?? this.msg,
      dateTime: dateTime ?? this.dateTime,
      numberOfMsg: numberOfMsg ?? this.numberOfMsg,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'image': image});
    result.addAll({'name': name});
    result.addAll({'msg': msg});
    result.addAll({'dateTime': dateTime});
    result.addAll({'numberOfMsg': numberOfMsg});

    return result;
  }

  factory ChatListModel.fromMap(Map<String, dynamic> map) {
    return ChatListModel(
      id: map['id']?.toInt() ?? 0,
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      msg: map['msg'] ?? '',
      dateTime: map['dateTime'] ?? '',
      numberOfMsg: map['numberOfMsg'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatListModel.fromJson(String source) =>
      ChatListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatListModel(id: $id, image: $image, name: $name, msg: $msg, dateTime: $dateTime, numberOfMsg: $numberOfMsg)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatListModel &&
        other.id == id &&
        other.image == image &&
        other.name == name &&
        other.msg == msg &&
        other.dateTime == dateTime &&
        other.numberOfMsg == numberOfMsg;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        name.hashCode ^
        msg.hashCode ^
        dateTime.hashCode ^
        numberOfMsg.hashCode;
  }
}
