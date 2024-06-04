import 'dart:io';
import 'package:get/get.dart';
import 'package:tiktok/controllers/upload_video_controller.dart';
import 'package:tiktok/views/widgets/text_input.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConfirmScrenn extends StatefulWidget {
  File videoFile;
  String videoPath;
  ConfirmScrenn({Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfirmScrenn();
}

class _ConfirmScrenn extends State<ConfirmScrenn> {
  late VideoPlayerController vdController;

  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  @override
  void initState() {
    super.initState();

    setState(() {
      vdController = VideoPlayerController.file(widget.videoFile);
    });
    vdController.initialize();
    vdController.play();
    vdController.setVolume(1);
    vdController.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();

    vdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: VideoPlayer(vdController),
                )),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 25,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextInputField(
                      controller: _songController,
                      labelText: "Song Name",
                      icon: Icons.music_note,
                      obIs: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 25,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextInputField(
                      controller: _captionController,
                      labelText: "Caption",
                      icon: Icons.closed_caption,
                      obIs: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () => uploadVideoController.uploadVideo(
                          _songController.text,
                          _captionController.text,
                          widget.videoPath),
                       
                      child: const Text(
                        "Share",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
