import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../authentication/widgets/sign_up_form.dart';
import '../controller/become_seller_cubit.dart';
import '../controller/become_seller_state_model.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sellerCubit = context.read<BecomeSellerCubit>();
    return BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
      // buildWhen: (previous, current) => previous.logo != current.logo,
      builder: (context, state) {
        final isImage = state.logo.isNotEmpty;
        final capturedImage = state.logo;
        final s = state.sellerState;
        print('logoImage: $capturedImage');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150.0,
              margin: const EdgeInsets.only(top: 10.0, bottom: 6.0),
              width: 160.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0XFFEBEBEB),
                //borderRadius: BorderRadius.circular(4.0),
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
                        const SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () async {
                            final image = await Utils.pickSingleImage();
                            sellerCubit.logoChange(image ?? '');
                          },
                          child: const Text(
                            'Logo',
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
              if (s.error.logo.isNotEmpty) ErrorText(text: s.error.logo.first)
            ],
            const SizedBox(height: 20.0),
          ],
        );
      },
    );
  }
}
