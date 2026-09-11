import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBlock extends StatefulWidget{
  final String assetPath;
  final VoidCallback onVideoFinished;
  const VideoBlock({
    super.key,
    required this.assetPath,
    required this.onVideoFinished,
    });

  @override
  State<VideoBlock> createState() => _VideoBlockState();

}

class _VideoBlockState extends State<VideoBlock>{
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.assetPath)
    ..initialize().then((_) {
        setState(() {});
        controller.play();
      });
    controller.addListener(() {
      if (
        controller.value.position >= controller.value.duration
        ) {widget.onVideoFinished();}
        }
        );
      }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
  }
