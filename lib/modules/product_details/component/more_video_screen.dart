import 'package:flutter/material.dart';

import '/widgets/rounded_app_bar.dart';
import '../model/video_model.dart';
import 'video_component.dart';

class MoreVideoScreen extends StatelessWidget {
  const MoreVideoScreen({super.key, required this.videos});
  final List<VideoModel> videos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Videos'),
      body: ListView.builder(
          itemCount: videos.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final video = videos[index];
            return VideoPlayWidget(video: video);
          }),
    );
  }
}
