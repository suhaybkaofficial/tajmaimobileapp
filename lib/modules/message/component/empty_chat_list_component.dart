import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';

class EmptyChatListComponent extends StatelessWidget {
  const EmptyChatListComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomImage(path: Kimages.emptyChatList),
            const SizedBox(height: 43),
            Text(
              'No Message Found!',
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold, height: 2),
            ),
            const Text(
              'Its seens, no messages in your inbox.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: iconGreyColor, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              child: PrimaryButton(
                  text: 'Start  a Conversation', onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
