import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/game_page/details/bottom_row.dart';
import 'package:mafia/app/modules/pages/game_page/details/game_player_card.dart';
import 'package:mafia/app/modules/pages/game_page/details/header.dart';
import 'package:mafia/app/modules/pages/game_page/night_page/night_page.dart';

class GamePage extends GetView<GameController> {
  final homeCtrl = Get.find<HomeController>();
  final gameCtrl = Get.find<GameController>();

  GamePage({Key? key}) : super(key: key);
  int? index;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Header(),
          Obx(
            () => gameCtrl.isDay.value
                ? Expanded(
                    child: GetBuilder<GameController>(
                      builder: ((controller) => Theme(
                            data:
                                ThemeData(canvasColor: white.withOpacity(0.2)),
                            child: ReorderableListView(
                              onReorder: (oldIndex, newIndex) {
                                controller.reorderPlayerList(
                                    oldIndex, newIndex);
                              },
                              children: [
                                ...homeCtrl.gamePlayerList.map((e) {
                                  return InkWell(
                                    key: ValueKey(e),
                                    child: GamePlayerCard(player: e),
                                  );
                                })
                              ],
                            ),
                          )),
                    ),
                  )
                : NightPage(),
          ),
          BottomRow()
        ],
      ),
    ));
  }
}
