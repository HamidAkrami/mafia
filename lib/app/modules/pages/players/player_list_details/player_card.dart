import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/mafia_player_model.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/styles.dart';

class PlayerCard extends StatelessWidget {
  PlayerCard({
    Key? key,
    this.name,
    this.mafiaPlayers,
    this.index,
  }) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  String? name;
  String? image = "assets/images/gggg.png";
  int? index;

  MafiaPlayers? mafiaPlayers;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Text(
            "${index! + 1} - ",
            style: Rstyle().optionStyle,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              height: Get.width * 0.11,
              decoration: BoxDecoration(
                color: Color(0xff191919),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  name!,
                  overflow: TextOverflow.ellipsis,
                  style: Rstyle().optionStyle,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () {
              homeCtrl.removePlayer(mafiaPlayers!);
            },
            child: Container(
                height: Get.width * 0.09,
                width: Get.width * 0.09,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: redDark)),
                child: Image(
                  image: AssetImage("assets/images/remove.png"),
                )),
          ),
          SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () {
              homeCtrl.onListItemTap(index);
              homeCtrl.addPlayer(mafiaPlayers!);
            },
            child: Container(
                alignment: Alignment.center,
                height: Get.width * 0.09,
                width: Get.width * 0.23,
                decoration: BoxDecoration(
                    color: homeCtrl.playerList[index!].isPlay!
                        ? greenDark.withOpacity(0.05)
                        : greenDark,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: greenDark)),
                child: homeCtrl.playerList[index!].isPlay!
                    ? Image.asset("assets/images/done.png")
                    : Text(
                        "انتخاب",
                        style: Rstyle().optionStyle,
                      )),
          )
        ],
      ),
    );

    // Column(
    //   children: [
    //     Container(
    //       height: Get.height * 0.003,
    //       color: Colors.white,
    //     ),
    //     Container(
    //       height: Get.height * 0.06,
    //       width: Get.width,
    //       color: Colors.black,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Row(
    //             children: [
    //               Image.asset(image!),
    //               mafiaPlayers!.isPlay!
    //                   ? const Icon(
    //                       Icons.done,
    //                       size: 34,
    //                       color: Colors.white,
    //                     )
    //                   : Container()
    //             ],
    //           ),
    //           Expanded(
    //             child: Padding(
    //               padding: const EdgeInsets.only(right: 10),
    //               child: Text(
    //                 name!,
    //                 textAlign: TextAlign.right,
    //                 style: Rstyle().nameStyle,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Container(
    //       height: Get.height * 0.003,
    //       color: Colors.white,
    //     ),
    //   ],
    // );
  }
}
