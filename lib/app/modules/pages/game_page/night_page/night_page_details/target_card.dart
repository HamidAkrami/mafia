import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/game_model.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';

class TargetCard extends StatelessWidget {
  final gameCtrl = Get.find<GameController>();
  TargetCard({Key? key, required this.player}) : super(key: key);
  GameModel? player;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: player!.isRemove!
          ? null
          : () {
              gameCtrl.targetPlayer(player!);
            },
      child: Container(
        margin: EdgeInsets.all(5),
        height: Get.width * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: player!.isRemove!
                            ? grey
                            : player!.mafia == 0
                                ? blueDark
                                : redDark),
                    borderRadius: BorderRadius.circular(5)),
                child: player!.isRemove!
                    ? Image.asset("assets/images/dead.png")
                    : player!.isTargeted!
                        ? Image.asset(
                            "assets/images/dead.png",
                            color: white,
                          )
                        : Container(),
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
                          ? grey
                          : player!.mafia == 0
                              ? blueDark.withOpacity(0.3)
                              : redDark.withOpacity(0.3)),
                  child: Text(
                    player!.name!,
                    style: TextStyle(
                        color:
                            player!.isRemove! ? white.withOpacity(0.4) : white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
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
                              : player!.mafia == 0
                                  ? blueDark
                                  : redDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
