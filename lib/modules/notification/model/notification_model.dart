import 'dart:convert';

class NotificationModel {
  final int id;
  final String text;
  final String image;
  final String time;
  NotificationModel({
    required this.id,
    required this.text,
    required this.image,
    required this.time,
  });

  NotificationModel copyWith({
    int? id,
    String? text,
    String? image,
    String? time,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      text: text ?? this.text,
      image: image ?? this.image,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'text': text});
    result.addAll({'image': image});
    result.addAll({'time': time});

    return result;
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id']?.toInt() ?? 0,
      text: map['text'] ?? '',
      image: map['image'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(id: $id, text: $text, image: $image, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.id == id &&
        other.text == text &&
        other.image == image &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode ^ image.hashCode ^ time.hashCode;
  }
}
