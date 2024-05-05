import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../profile/controllers/updated_info/updated_info_cubit.dart';
import '../controller/delivery_man_cubit.dart';
import '../controller/delivery_man_state_model.dart';

class DeliveryManImage extends StatelessWidget {
  const DeliveryManImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deliveryCubit = context.read<DeliveryManCubit>();
    final defaultImage =
        context.read<UserProfileInfoCubit>().updatedInfo.defaultImage!.image;
    return BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
      //buildWhen: (previous, current) => previous.manImage != current.manImage,
      builder: (context, state) {
        String profileImage = state.manImage.isNotEmpty
            ? state.manImage
            : RemoteUrls.imageUrl(defaultImage);

        // profileImage =
        //     state.manImage.isNotEmpty ? state.manImage : profileImage;
        print('imggggg ${state.manImage}');

        return Container(
          height: size.height * 0.25,
          width: size.height * 0.25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0XFFEBEBEB),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: const Color(0xff333333).withOpacity(0.18)),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: CustomImage(
                    path: profileImage,
                    fit: BoxFit.cover,
                    height: size.height * 0.23,
                    width: size.height * 0.23,
                    isFile: state.manImage.isNotEmpty,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 20,
                child: InkWell(
                  onTap: () async {
                    final image = await Utils.pickSingleImage();
                    deliveryCubit.changeManImage(image ?? '');
                  },
                  child: const CircleAvatar(
                    maxRadius: 18.0,
                    backgroundColor: Color(0xff18587A),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
