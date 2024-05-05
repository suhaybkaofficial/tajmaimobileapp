import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ToggleButtonComponent extends StatefulWidget {
  const ToggleButtonComponent({
    super.key,
    required this.onChange,
    required this.textList,
    this.initialLabelIndex = 0,
  });

  final void Function(int index) onChange;
  final int initialLabelIndex;
  final List<String> textList;

  @override
  State<ToggleButtonComponent> createState() => _ToggleButtonComponentState();
}

class _ToggleButtonComponentState extends State<ToggleButtonComponent> {
  late int initialLabelIndex;
  late List<String> textList;

  @override
  void initState() {
    super.initState();
    initialLabelIndex = widget.initialLabelIndex;
    textList = widget.textList;
  }

  List<Widget> getBtns() {
    final childList = <Widget>[];

    textList.asMap().forEach(
      (key, value) {
        childList.add(_buildSingleBtn(key, value));
      },
    );
    return childList;
  }

  Widget _buildSingleBtn(int key, String value) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: InkWell(
        onTap: () => setState(() {
          initialLabelIndex = key;
          widget.onChange(initialLabelIndex);
        }),
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: initialLabelIndex == key
                        ? Utils.dynamicPrimaryColor(context)
                        : grayBorderColor)),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: initialLabelIndex != key ? iconGreyColor : blackColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: getBtns(),
        ),
      ),
    );
  }
}
