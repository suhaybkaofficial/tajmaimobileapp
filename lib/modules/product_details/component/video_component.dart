import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:shop_o/utils/constants.dart';

import '../../../core/router_name.dart';
import '../model/video_model.dart';

class VideoComponent extends StatelessWidget {
  const VideoComponent({super.key, required this.videos});

  final List<VideoModel> videos;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            itemCount: videos.length >= 2 ? 2 : videos.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final video = videos[index];
              return VideoPlayWidget(video: video);
            }),
        SizedBox(height: videos.length > 2 ? 14.0 : 0.0),
        videos.length > 2
            ? TextButton(
                onPressed: () => Navigator.pushNamed(
                    context, RouteNames.moreVideoScreen,
                    arguments: videos),
                child: const Text(
                  'See More Video',
                  style: TextStyle(color: greenColor, fontSize: 18.0),
                ),
              )
            : const SizedBox(),
        SizedBox(height: videos.length > 2 ? 10.0 : 0.0),
      ],
    );
  }
}

class VideoPlayWidget extends StatefulWidget {
  const VideoPlayWidget({super.key, required this.video});

  final VideoModel video;

  @override
  State<VideoPlayWidget> createState() => _VideoPlayWidgetState();
}

class _VideoPlayWidgetState extends State<VideoPlayWidget> {
  late CustomVideoPlayerController _customVideoPlayerController;
  //late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    //initVideoController();
    super.initState();
  }

  // void initVideoController() {
  //   final videoUrl = RemoteUrls.videoUrl(widget.video.videoPath);
  //   print('videoUrl $videoUrl');
  //   _videoPlayerController =
  //       VideoPlayerController.networkUrl(Uri.parse(videoUrl))
  //         ..initialize().then((value) {
  //           setState(() {});
  //           debugPrint('initializing video');
  //         });
  //   _customVideoPlayerController = CustomVideoPlayerController(
  //     context: context,
  //     videoPlayerController: _videoPlayerController,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0)
          .copyWith(top: 0),
      child: CustomVideoPlayer(
        customVideoPlayerController: _customVideoPlayerController,
      ),
    );
  }
}
