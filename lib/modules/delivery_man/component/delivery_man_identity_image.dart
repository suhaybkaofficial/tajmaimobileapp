import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../authentication/widgets/sign_up_form.dart';
import '../controller/delivery_man_cubit.dart';
import '../controller/delivery_man_state_model.dart';

class DeliveryManIdentityImage extends StatelessWidget {
  const DeliveryManIdentityImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deliveryCubit = context.read<DeliveryManCubit>();
    return BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
      buildWhen: (previous, current) {
        print('previous $previous');
        print('current $current');
        print('preImg ${previous.idnImage}');
        print('curImg ${current.idnImage}');
        return previous.idnImage != current.idnImage;
      },
      builder: (context, state) {
        final isImage = state.idnImage.isNotEmpty;
        final capturedImage = state.idnImage;
        final s = state.deliveryState;
        print('identityImage: $capturedImage');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180.0,
              margin: const EdgeInsets.only(top: 10.0, bottom: 6.0),
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
                            deliveryCubit.changeIdnImage(image ?? '');
                          },
                          child: const Text(
                            'Identity Image',
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
            if (s is DeliveryManFieldError) ...[
              if (s.errors.idnImage.isNotEmpty)
                ErrorText(text: s.errors.idnImage.first)
            ],
            const SizedBox(height: 20.0),
          ],
        );
      },
    );
  }
}
