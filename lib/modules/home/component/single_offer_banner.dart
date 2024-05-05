import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/remote_urls.dart';
import '/modules/home/model/slider_model.dart';
import '/widgets/capitalized_word.dart';
import '../../../core/router_name.dart';
import '../../../utils/language_string.dart';

class SingleOfferBanner extends StatelessWidget {
  const SingleOfferBanner({
    Key? key,
    required this.slider,
  }) : super(key: key);
  final SliderModel? slider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              RemoteUrls.imageUrl(slider!.image),
            ),
            fit: BoxFit.cover),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    slider!.badge,
                    style: GoogleFonts.poppins(
                      height: 1.5,
                      fontSize: 20.0,
                      color: const Color(0xff18587A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  slider!.titleOne,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xff333333), height: 1.6),
                ),
                const SizedBox(height: 10),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.productDetailsScreen,
                      arguments: slider!.productSlug,
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Language.shopNow.capitalizeByWord(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
