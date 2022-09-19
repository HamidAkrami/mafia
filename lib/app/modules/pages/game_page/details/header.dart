import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/widgets/audio_player.dart';

class Header extends StatelessWidget {
  Header({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  final gameCtrl = Get.find<GameController>();

  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.paused;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: Get.width * 0.13,
      color: white.withOpacity(0.1),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(() => gameCtrl.isDay.value
                  ? Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          homeCtrl.showRole.value = !homeCtrl.showRole.value;
                        },
                        child: Image.asset(
                          homeCtrl.showRole.value
                              ? "assets/images/show.png"
                              : "assets/images/dontShow.png",
                        ),
                      ),
                    )
                  : AudioPlayerWidget(
                      iconImage: "assets/images/nightmusic.png",
                      musicPath: "music/music2.mp3",
                    )),
            ),
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "روز اول",
                  style: TextStyle(
                      fontSize: 20, color: white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset("assets/images/close.png")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
