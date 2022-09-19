import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';

class BottomRow extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final gameCtrl = Get.find<GameController>();
  BottomRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.13,
      color: white.withOpacity(0.1),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  gameCtrl.itsDay();
                },
                child: gameCtrl.isNight.value
                    ? Image.asset(
                        "assets/images/day.png",
                        color: black,
                        width: 20,
                        height: 20,
                      )
                    : Image.asset(
                        "assets/images/day.png",
                        width: 20,
                        height: 20,
                      )),
            InkWell(
                onTap: () {
                  gameCtrl.itsNight();

                  if (gameCtrl.createList.value) {
                    gameCtrl.createList.value = false;
                  }
                },
                child: gameCtrl.isNight.value
                    ? Image.asset(
                        "assets/images/night.png",
                        color: white,
                        width: 20,
                        height: 20,
                      )
                    : Image.asset(
                        "assets/images/night.png",
                        color: black,
                        width: 20,
                        height: 20,
                      )),
          ],
        ),
      ),
    );
  }
}
