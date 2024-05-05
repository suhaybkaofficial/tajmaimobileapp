import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String userId;
  final String deviceToken;

  const NotificationModel({required this.userId, required this.deviceToken});

  @override
  List<Object> get props => [userId, deviceToken];
}
