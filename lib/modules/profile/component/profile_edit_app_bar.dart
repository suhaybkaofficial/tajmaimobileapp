import 'package:flutter/material.dart';

import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';

class ProfileEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const ProfileEditAppBar({
    Key? key,
    this.onTap,
    this.height = 82,
  }) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                height: height - 80,
                decoration: BoxDecoration(
                  color: Utils.dynamicPrimaryColor(context),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff333333).withOpacity(.18),
                          blurRadius: 70),
                    ],
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const CustomImage(
                            path: Kimages.kNetworkImage,
                            height: 170,
                            width: 170,
                          ),
                        ),
                        const Positioned(
                          right: 10,
                          bottom: 10,
                          child: CircleAvatar(
                            backgroundColor: Color(0xff18587A),
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        )
                      ],
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
