import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/game_model.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/game_page/night_page/night_page_details/target_card.dart';

class AbilityTargetDialog extends StatelessWidget {
  final gameCtrl = Get.find<GameController>();
  final homeCtrl = Get.find<HomeController>();
  AbilityTargetDialog({Key? key, required this.player}) {
    print(player!.role);
  }
  GameModel? player;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff191919),
      ),
      height: Get.width * 1.4,
      child: Column(
        children: [
          Expanded(
            child: GetBuilder<GameController>(
              builder: ((controller) => Theme(
                    data: ThemeData(canvasColor: white.withOpacity(0.2)),
                    child: ReorderableListView(
                      onReorder: (oldIndex, newIndex) {
                        controller.reorderPlayerList(oldIndex, newIndex);
                      },
                      children: [
                        ...homeCtrl.gamePlayerList.map((e) {
                          return InkWell(
                            key: ValueKey(e),
                            child: TargetCard(player: e),
                          );
                        })
                      ],
                    ),
                  )),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: SubmitTarget(
                color: redDark,
                text: "لغو",
                onPress: () {
                  gameCtrl.cancelTarget(player!);
                  Get.back();
                },
              )),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: SubmitTarget(
                color: greenDark,
                text: "تایید",
                onPress: () {
                  gameCtrl.submitTarget(player!);
                },
              )),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}

class SubmitTarget extends StatelessWidget {
  SubmitTarget({
    required this.color,
    required this.text,
    required this.onPress,
    Key? key,
  }) : super(key: key);
  Color? color;
  String? text;
  VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        height: Get.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Text(
          text!,
          style: TextStyle(color: white, fontSize: 14),
        ),
      ),
    );
  }
}
