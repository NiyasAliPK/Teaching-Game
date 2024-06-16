import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/big_or_small_view.dart';
import 'package:teaching_game/app/utils/utils.dart';
import 'package:video_player/video_player.dart';

class IntroVideoView extends StatefulWidget {
  const IntroVideoView({super.key});

  @override
  State<IntroVideoView> createState() => _IntroVideoViewState();
}

class _IntroVideoViewState extends State<IntroVideoView> {
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _videoPlayerController = VideoPlayerController.asset(
        'assets/musics/big_buck_bunny_720p_20mb.mp4',
        videoPlayerOptions: VideoPlayerOptions())
      ..initialize().then((_) {
        _videoPlayerController!.play();
        _videoPlayerController!.setLooping(false);
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            AspectRatio(
              aspectRatio: context.width / context.height,
              child: VideoPlayer(_videoPlayerController!),
            ),
            Positioned(
              bottom: context.width * 0.01,
              right: context.width * 0.015,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.75)),
                  onPressed: () async {
                    await SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                    ]);
                    Get.offAll(() => const BigOrSmallView());
                  },
                  child: const Text("Skip")),
            )
          ],
        ),
      ),
    );
  }
}
