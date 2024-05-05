import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../authentication/widgets/sign_up_form.dart';
import '../controller/become_seller_cubit.dart';
import '../controller/become_seller_state_model.dart';

class BannerImage extends StatelessWidget {
  const BannerImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sellerCubit = context.read<BecomeSellerCubit>();
    return BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
      builder: (context, state) {
        final isImage = state.bannerImage.isNotEmpty;
        final capturedImage = state.bannerImage;
        final s = state.sellerState;
        print('bannerImage: $capturedImage');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              margin: const EdgeInsets.only(top: 14.0, bottom: 6.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0XFFEBEBEB),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: isImage
                  ? CustomImage(
                      path: capturedImage,
                      fit: BoxFit.cover,
                      isFile: isImage,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomImage(path: Kimages.placeHolderImage),
                        const SizedBox(width: 16.0),
                        GestureDetector(
                          onTap: () async {
                            final image = await Utils.pickSingleImage();
                            sellerCubit.bannerChange(image ?? '');
                          },
                          child: const Text(
                            'Browse Banner Image',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            if (s is BecomeSellerFormValidate) ...[
              if (s.error.bannerImage.isNotEmpty)
                ErrorText(text: s.error.bannerImage.first)
            ],
            const SizedBox(height: 20.0),
          ],
        );
      },
    );
  }
}
