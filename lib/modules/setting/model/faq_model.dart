import 'dart:convert';

import 'package:equatable/equatable.dart';

class FaqModel extends Equatable {
  final int id;
  final String question;
  final String answer;
  final int status;
  final String createdAt;
  final String updatedAt;

  final bool isExpanded;
  const FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.isExpanded = false,
  });

  FaqModel copyWith({
    int? id,
    String? title,
    String? question,
    String? answer,
    int? status,
    String? createdAt,
    String? updatedAt,
    bool? isExpanded,
  }) {
    return FaqModel(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'question': question});
    result.addAll({'answer': answer});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll({'isExpanded': isExpanded});

    return result;
  }

  factory FaqModel.fromMap(Map<String, dynamic> map) {
    return FaqModel(
      id: map['id']?.toInt() ?? 0,
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FaqModel.fromJson(String source) =>
      FaqModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FaqModel(id: $id, question: $question, answer: $answer, status: $status, created_at: $createdAt, updated_at: $updatedAt, isExpanded: $isExpanded)';
  }

  @override
  List<Object> get props {
    return [
      id,
      question,
      answer,
      status,
      createdAt,
      updatedAt,
      isExpanded,
    ];
  }
}
