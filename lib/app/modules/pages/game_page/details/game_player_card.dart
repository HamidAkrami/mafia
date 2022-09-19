import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/game_model.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/styles.dart';

class GamePlayerCard extends StatelessWidget {
  final gameCtrl = Get.find<GameController>();
  final homeCtrl = Get.find<HomeController>();
  GamePlayerCard({Key? key, this.player}) : super(key: key);
  GameModel? player;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.all(3),
        height: Get.width * 0.11,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.menu,
                color: white,
              ),
              SizedBox(
                width: 6,
              ),
              InkWell(
                onTap: () {
                  gameCtrl.killPlayer(player!);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: player!.isRemove!
                              ? grey
                              : homeCtrl.showRole.value == false
                                  ? white.withOpacity(0.6)
                                  : player!.mafia == 0
                                      ? blueDark
                                      : redDark),
                      borderRadius: BorderRadius.circular(5)),
                  child: player!.isRemove!
                      ? Image.asset("assets/images/dead.png")
                      : Container(),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerRight,
                  height: Get.width * 0.11,
                  padding: EdgeInsets.only(right: 15),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: player!.isRemove!
                          ? white.withOpacity(0.1)
                          : homeCtrl.showRole.value == false
                              ? white.withOpacity(0.1)
                              : player!.mafia == 0
                                  ? blueDark.withOpacity(0.2)
                                  : redDark.withOpacity(0.2)),
                  child: Text(
                    player!.name!,
                    style: TextStyle(
                        color: player!.isRemove! ? grey : white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              homeCtrl.showRole.value == true
                  ? Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 1,
                              color: player!.isRemove!
                                  ? grey
                                  : homeCtrl.showRole.value == false
                                      ? white.withOpacity(0.1)
                                      : player!.mafia == 0
                                          ? blueDark
                                          : redDark),
                        ),
                        child: FittedBox(
                          child: Text(
                            player!.role!,
                            style: TextStyle(
                                color: player!.isRemove!
                                    ? grey
                                    : homeCtrl.showRole.value == false
                                        ? white.withOpacity(0.1)
                                        : player!.mafia == 0
                                            ? blueDark
                                            : redDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
