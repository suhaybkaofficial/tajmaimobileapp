import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_image.dart';
import '../model/notification_model.dart';

class SingleNofitication extends StatelessWidget {
  const SingleNofitication({
    Key? key,
    required this.notification,
    this.color,
  }) : super(key: key);
  final NotificationModel notification;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageCirculer(notification),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              notification.text,
              maxLines: 2,
              style: const TextStyle(fontSize: 16, color: Color(0xff85959E)),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            notification.time,
            style: const TextStyle(color: Color(0xff85959E)),
          )
        ],
      ),
    );
  }

  Widget _buildImageCirculer(NotificationModel item) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CustomImage(
            height: 50,
            width: 50,
            path: item.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
