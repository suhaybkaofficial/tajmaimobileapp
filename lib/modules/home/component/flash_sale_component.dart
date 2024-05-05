import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';

import '/modules/home/component/implemented_count_down.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/utils.dart';
import '../model/flash_sale_model.dart';

class FlashSaleComponent extends StatelessWidget {
  const FlashSaleComponent({
    Key? key,
    required this.flashSale,
  }) : super(key: key);

  final FlashSaleModel flashSale;

  @override
  Widget build(BuildContext context) {
    int endTime =
        DateTime.parse(flashSale.endTime).millisecondsSinceEpoch + 1000 * 30;
    // DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    if (endTime > 0) {
      return SliverToBoxAdapter(
        child: Container(
          height: 275,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          margin: const EdgeInsets.only(bottom: 10, top: 15),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  RemoteUrls.imageUrl(
                    flashSale.homepageImage,
                  ),
                ),
                fit: BoxFit.cover),
            color: Utils.dynamicPrimaryColor(context).withOpacity(0.05),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            // alignment: Alignment.center,
            children: [
              Expanded(
                child: CountdownTimer(
                  endTime: endTime,
                  widgetBuilder: (_, time) {
                    if (time == null) {
                      return Text(Language.saleOver.capitalizeByWord());
                    }
                    return ImplementedCountDown(time: time);

                    // Text(
                    //   'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: RichText(
                          text: TextSpan(
                            text: "WOO!\n",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: flashSale.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.flashScreen);
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
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
  }
}
