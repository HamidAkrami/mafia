import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/mafia_player_model.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/players/player_list_details/remove_dialog.dart';
import 'package:mafia/app/modules/pages/styles.dart';

class PlayerListHeader extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  PlayerListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.09,
      color: white.withOpacity(0.11),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              homeCtrl.selectAllPlayer();
            },
            child: Obx(
              () => Container(
                  margin: EdgeInsets.only(left: 9),
                  height: Get.width * 0.09,
                  width: Get.width * 0.23,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      border: Border.all(width: 1, color: greenDark),
                      color: !homeCtrl.selectedAll.value
                          ? greenDark
                          : greenDark.withOpacity(0.1)),
                  alignment: Alignment.center,
                  child: !homeCtrl.selectedAll.value
                      ? const FittedBox(
                          child: Text(
                          "انتخاب همه",
                          style: TextStyle(
                              color: white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ))
                      : Image.asset("assets/images/done.png")),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          RemovePlayersDialog(),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "بازیکنان",
                textScaleFactor: 0.8,
                style: Rstyle().titleStyle,
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
