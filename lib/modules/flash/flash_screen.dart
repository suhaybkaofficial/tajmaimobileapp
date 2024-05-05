import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import '/widgets/capitalized_word.dart';

import '/core/remote_urls.dart';
import '/modules/flash/controller/cubit/flash_cubit.dart';
import '/widgets/custom_image.dart';
import '../../utils/language_string.dart';
import '../category/component/product_card.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<FlashCubit>().getFalshSale();
    return Scaffold(
        // appBar: AppBar(title: Text('Flash Products'),backgroundColor: Colors.white.withOpacity(0.5),),
        extendBodyBehindAppBar: true,
        body: BlocBuilder<FlashCubit, FlashState>(builder: (context, state) {
          if (state is FlashSaleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FlashSaleError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is FlashSaleLoaded) {
            int endTime = DateTime.parse(state.flashModel.flashSale.endTime)
                    .millisecondsSinceEpoch +
                1000 * 30;
            return Column(
              children: [
                SafeArea(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomImage(
                            path: RemoteUrls.imageUrl(state.flashModel.flashSale.flashsalePageImage),
                            fit: BoxFit.fill),
                        Positioned(
                          right: 10.0,
                          bottom: 20.0,
                          child: CountdownTimer(
                            endTime: endTime,
                            widgetBuilder: (context, time) {
                              if (time == null) {
                                return Text(
                                    Language.saleOver.capitalizeByWord());
                              }
                              return Row(
                                children: [
                                  FlashCountDown(
                                      time: time.days!,
                                      title: 'Days',
                                      color: const Color(0xffEB5757)),
                                  FlashCountDown(
                                    time: time.hours!,
                                    title: 'Hrs',
                                    color: const Color(0xff2F80ED),
                                  ),
                                  FlashCountDown(
                                    time: time.min!,
                                    title: 'Min',
                                    color: const Color(0xff219653),
                                  ),
                                  FlashCountDown(
                                    time: time.sec!,
                                    title: 'Sec',
                                    color: const Color(0xffEB5757),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white.withOpacity(0.5),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                        // Text(state.flashModel.flashSale.title),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 230,
                      ),
                      itemCount: state.flashModel.products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            productModel: state.flashModel.products[index]);
                      }),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}

class FlashCountDown extends StatelessWidget {
  const FlashCountDown(
      {Key? key, required this.time, required this.title, required this.color})
      : super(key: key);
  final int time;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Center(
              child: Text(
                time.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1,
                    color: color),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
