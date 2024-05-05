import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/utils/constants.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../../widgets/rounded_app_bar.dart';

class ProfileOfferScreen extends StatelessWidget {
  const ProfileOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final banners = context.read<HomeControllerCubit>().homeModel.banners;
    return Scaffold(
      appBar: RoundedAppBar(titleText: Language.myOffers.capitalizeByWord()),
      body: Center(
        child: Text(
          'No Offer Available',
          style: GoogleFonts.inter(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: blackColor,
          ),
        ),
      ),
      // body: ListView.separated(
      //   separatorBuilder: (_, __) {
      //     return const SizedBox(height: 16);
      //   },
      //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      //   itemBuilder: (context, index) {
      //     return HotDealBanner(
      //       banner: banners[index],
      //       height: 150,
      //     );
      //   },
      //   itemCount: banners.length,
      // ),
    );
  }
}
