// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'seller_messages_dto.dart';

class SendMessageResponseDto extends Equatable {
  final MessagesDto message;
  final List<MessagesDto> messages;
  const SendMessageResponseDto({
    required this.message,
    required this.messages,
  });

  SendMessageResponseDto copyWith({
    MessagesDto? message,
    List<MessagesDto>? messages,
  }) {
    return SendMessageResponseDto(
      message: message ?? this.message,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message.toMap(),
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory SendMessageResponseDto.fromMap(Map<String, dynamic> map) {
    return SendMessageResponseDto(
      message: MessagesDto.fromMap(map['message'] as Map<String,dynamic>),
      messages: List<MessagesDto>.from((map['messages'] as List<dynamic>).map<MessagesDto>((x) => MessagesDto.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory SendMessageResponseDto.fromJson(String source) => SendMessageResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message, messages];
}
