import 'package:flutter/material.dart';
import '../model/notification_model.dart';
import 'single_notification.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    Key? key,
    required this.notificationList,
  }) : super(key: key);
  final List<NotificationModel> notificationList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: notificationList.length,
      itemBuilder: (context, index) {
        final item = notificationList[index];

        return SingleNofitication(
          notification: item,
          color: index == 3 ? const Color(0xffE8F3FF) : null,
        );
      },
    );
  }
}
