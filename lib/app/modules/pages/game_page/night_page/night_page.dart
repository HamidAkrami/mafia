import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/game_page/night_page/night_page_details/night_dialog_page.dart';
import 'package:mafia/app/modules/pages/game_page/night_page/night_page_details/night_page_player_card.dart';

class NightPage extends StatelessWidget {
  final gameCtrl = Get.find<GameController>();
  final homeCtrl = Get.find<HomeController>();
  NightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
            height: Get.width * 0.2,
            decoration: BoxDecoration(
                color: white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: white.withOpacity(0.6))),
            child: const Text(
              "لطفا ترتیب بیدار شدن نقش ها را تعیین کنید سپس دکمه “شروع شب” را بزنید",
              style: TextStyle(
                fontSize: 16,
                color: redDark,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GetBuilder<GameController>(
              builder: ((controller) => Theme(
                    data: ThemeData(canvasColor: white.withOpacity(0.2)),
                    child: ReorderableListView(
                      onReorder: (oldIndex, newIndex) {
                        controller.reorderNightList(oldIndex, newIndex);
                      },
                      children: [
                        ...gameCtrl.gameList.map((e) {
                          return InkWell(
                              key: ValueKey(e),
                              child: NightPagePlayerCard(
                                player: e,
                              ));
                        })
                      ],
                    ),
                  )),
            ),
          ),
          gameCtrl.isNight.value
              ? Container(
                  decoration: BoxDecoration(
                      color: white.withOpacity(0.1),
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: white.withOpacity(0.8), width: 0.1))),
                  height: Get.width * 0.12,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      gameCtrl.playersTarget.clear();
                      gameCtrl.index.value = 0;
                      gameCtrl.showResult.value = false;
                      gameCtrl.resultTargets.clear();

                      gameCtrl.roundSleep.value = false;
                      gameCtrl.nightList.clear();

                      gameCtrl.nightList.addAll(
                          gameCtrl.gameList.where((p0) => p0.ability == true));
                      for (var i = 0; i < gameCtrl.nightList.length; i++) {
                        if (homeCtrl.gamePlayerList[i].target != null ||
                            homeCtrl.gamePlayerList[i].target2 != null) {
                          homeCtrl.gamePlayerList[i].target = null;
                          homeCtrl.gamePlayerList[i].target2 = null;
                        }
                        homeCtrl.gamePlayerList[i].isTargeted = false;
                      }

                      showDialog(
                          context: context,
                          builder: (_) {
                            return NightDialogWidget();
                          });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Get.width * 0.08,
                      width: Get.width * 0.3,
                      decoration: BoxDecoration(
                        color: white.withOpacity(
                          0.06,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 0.6, color: white.withOpacity(0.12)),
                      ),
                      child: const Text(
                        "شروع شب",
                        style: TextStyle(
                            fontSize: 11,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
