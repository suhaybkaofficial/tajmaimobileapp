import 'package:flutter/material.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomImage(path: Kimages.emptyNotification),
          const SizedBox(height: 50),
          const Text(
            'Nothing Here !',
            style:
                TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 2),
          ),
          const Text(
            'Top the notifaction settings button bellow and chaeck again',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          PrimaryButton(text: 'Notificatio Settings', onPressed: () {})
        ],
      ),
    );
  }
}
