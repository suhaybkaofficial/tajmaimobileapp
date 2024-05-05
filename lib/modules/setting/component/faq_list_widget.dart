import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../model/faq_model.dart';

class FaqListWidget extends StatefulWidget {
  const FaqListWidget({
    Key? key,
    required this.faqList,
  }) : super(key: key);

  final List<FaqModel> faqList;

  @override
  State<FaqListWidget> createState() => _FaqListWidgetState();
}

class _FaqListWidgetState extends State<FaqListWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ExpansionPanelList(
        expansionCallback: ((panelIndex, isExpanded) {
          widget.faqList.asMap().forEach((key, value) {
            widget.faqList[key] =
                widget.faqList[key].copyWith(isExpanded: false);
          });
          widget.faqList[panelIndex] =
              widget.faqList[panelIndex].copyWith(isExpanded: !isExpanded);
          setState(() {});
        }),
        expandedHeaderPadding: EdgeInsets.zero,
        dividerColor: borderColor.withOpacity(.4),
        elevation: 0,
        children: widget.faqList
            .map(
              (e) => ExpansionPanel(
                isExpanded: e.isExpanded,
                backgroundColor: e.isExpanded
                    ? Utils.dynamicPrimaryColor(context).withOpacity(.1)
                    : null,
                canTapOnHeader: true,
                headerBuilder: (_, bool isExpended) => ListTile(
                  title: Text(e.question, maxLines: 1),
                  // contentPadding: EdgeInsets.zero,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Html(data: e.answer),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
