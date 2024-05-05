import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class ChatListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const ChatListAppBar({Key? key, this.height = 82}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SizedBox(
          height: height,
          child: Stack(
            children: [

              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    border: Border.all(color: grayColor)
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: const Color(0xff333333).withOpacity(.18),
                    //       blurRadius: 70),
                    // ],
                  ),
                  child: TextFormField(
                    decoration: inputDecorationTheme.copyWith(
                      prefixIcon: const Icon(Icons.search, size: 26),
                      hintText: 'Search Name...',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
