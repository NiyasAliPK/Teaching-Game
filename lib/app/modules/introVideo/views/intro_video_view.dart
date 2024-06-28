import 'dart:developer';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/home/controllers/home_controller.dart';
import 'package:teaching_game/app/modules/introVideo/controllers/intro_video_controller.dart';
import 'package:teaching_game/app/utils/utils.dart';
import 'package:video_player/video_player.dart';

class IntroVideoView extends StatefulWidget {
  final int index;
  final String path;
  const IntroVideoView({super.key, required this.index, required this.path});

  @override
  _IntroVideoViewState createState() => _IntroVideoViewState();
}

class _IntroVideoViewState extends State<IntroVideoView> {
  @override
  void initState() {
    _controller.flickManager = FlickManager(
      onVideoEnd: () {
        _controller.navigateScreen(index: widget.index);
      },
      videoPlayerController: VideoPlayerController.asset(widget.path),
    );
    _controller.showSkipButton();
    super.initState();
  }

  @override
  void dispose() {
    _controller.flickManager?.dispose();

    super.dispose();
  }

  final IntroVideoController _controller = Get.put(IntroVideoController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            AspectRatio(
              aspectRatio: context.width / context.height,
              child: Center(
                child: FlickVideoPlayer(
                  flickVideoWithControls: const FlickVideoWithControls(
                    controls: SizedBox.shrink(),
                  ),
                  preferredDeviceOrientation: const [
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft,
                  ],
                  preferredDeviceOrientationFullscreen: const [
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft,
                  ],
                  flickManager: _controller.flickManager!,
                ),
              ),
            ),
            Positioned(
                top: context.height * 0.075,
                right: context.width * 0.015,
                child: Obx(() => _controller.isVisible.value
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryPink.withOpacity(0.75)),
                        onPressed: () async {
                          // await _controller.flickManager?.flickControlManager
                          //     ?.seekTo(Duration.zero);
                          await _controller.flickManager?.flickControlManager
                              ?.pause();
                          _controller.navigateScreen(index: widget.index);
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: Colors.white),
                        ))
                    : const SizedBox.shrink()))
          ],
        ),
      ),
    );
  }
}
