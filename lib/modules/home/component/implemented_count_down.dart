import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import '/widgets/capitalized_word.dart';

import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import 'custom_count_down.dart';

class ImplementedCountDown extends StatelessWidget {
  const ImplementedCountDown({Key? key,required this.time}) : super(key: key);
  final CurrentRemainingTime time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCircularCountDownProgress(
          maxValue: time.days! + 10,
          title: Language.days.capitalizeByWord(),
          value: time.days!,
          key: UniqueKey(),
          color: const Color(0xffEB5757),
        ),
        Container(
          height: 1,
          width: 20,
          color: grayColor,
        ),
        CustomCircularCountDownProgress(
          maxValue: 24,
          title: Language.hours.capitalizeByWord(),
          value: time.hours!,
          key: UniqueKey(),
          color: const Color(0xff2F80ED),
        ),
        Container(
          height: 1,
          width: 20,
          color: grayColor,
        ),
        CustomCircularCountDownProgress(
          maxValue: 60,
          title: Language.minutes.capitalizeByWord(),
          value: time.min!,
          key: UniqueKey(),
          color: const Color(0xff219653),
        ),
        Container(
          height: 1,
          width: 20,
          color: grayColor,
        ),
        CustomCircularCountDownProgress(
          maxValue: 60,
          title: Language.second.capitalizeByWord(),
          value: time.sec!,
          key: UniqueKey(),
          color: const Color(0xffEB5757),
        ),
      ],
    );
  }
}
