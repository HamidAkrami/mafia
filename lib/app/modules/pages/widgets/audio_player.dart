import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';

class AudioPlayerWidget extends StatefulWidget {
  AudioPlayerWidget({Key? key, this.iconImage, this.musicPath})
      : super(key: key);
  String? iconImage;
  String? musicPath;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.paused;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.onPlayerComplete.listen((event) {
      audioPlayer.stop();
      print("compelete");
      setState(() {
        playerState = PlayerState.completed;
      });
    });

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        playerState = event;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (playerState != PlayerState.playing) {
            audioPlayer.play(AssetSource(widget.musicPath!));
          } else if (playerState == PlayerState.playing) {
            audioPlayer.pause();
          }
        },
        child: Container(
            height: Get.width * 0.1,
            width: Get.width * 0.05,
            color: Colors.transparent,
            child: playerState != PlayerState.playing
                ? Image.asset(widget.iconImage!)
                : Image.asset("assets/images/pausenightmusic.png")));
  }
}
