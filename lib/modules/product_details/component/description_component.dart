import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DescriptionComponent extends StatelessWidget {
  const DescriptionComponent(this.description, {Key? key}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(data: description),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
