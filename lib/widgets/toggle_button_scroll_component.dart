import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ToggleButtonScrollComponent extends StatefulWidget {
  const ToggleButtonScrollComponent({
    Key? key,
    required this.onChange,
    required this.textList,
    this.initialLabelIndex = 0,
  }) : super(key: key);

  final void Function(int index) onChange;
  final int initialLabelIndex;
  final List<String> textList;

  @override
  State<ToggleButtonScrollComponent> createState() =>
      _ToggleButtonScrollComponentState();
}

class _ToggleButtonScrollComponentState
    extends State<ToggleButtonScrollComponent> {
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
    return InkWell(
      onTap: () => setState(() {
        initialLabelIndex = key;
        widget.onChange(initialLabelIndex);
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: initialLabelIndex == key
              ? Utils.dynamicPrimaryColor(context)
              : Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: initialLabelIndex != key ? textGreyColor : blackColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(2),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: getBtns(),
        ),
      ),
    );
  }
}
