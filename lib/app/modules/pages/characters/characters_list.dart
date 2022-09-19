import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';

import 'package:mafia/app/modules/pages/characters/charecters_details/chose_character_lenght.dart';
import 'package:mafia/app/modules/pages/characters/charecters_details/role_widget.dart';
import 'package:mafia/app/modules/pages/styles.dart';
import 'package:mafia/app/modules/pages/players/player_list_details/chosen_players_length.dart';
import 'package:mafia/app/modules/pages/widgets/custom_container.dart';
import 'package:mafia/app/modules/routes/app_routes.dart';

class CharacterList extends StatelessWidget {
  CharacterList({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CustomContainer(
            width: Get.width,
            height: Get.height * 0.09,
            color: white.withOpacity(0.1),
            text: "انتخاب نقش ها",
            style: Rstyle().titleStyle,
          ),
          Expanded(
              child: GetBuilder<HomeController>(
            builder: (controller) => ListView(
              padding: EdgeInsets.symmetric(horizontal: 6),
              children: [
                RoleWidget(
                  list1: homeCtrl.cityTeam1,
                  list2: homeCtrl.cityTeam2,
                  title: "گروه شهروند",
                  color: blueDark,
                  index: homeCtrl.allShahrIndex.value,
                ),
                RoleWidget(
                  list1: homeCtrl.mafiaTeam2,
                  list2: homeCtrl.mafiaTeam1,
                  title: "گروه مـافیـا",
                  color: redDark,
                  index: homeCtrl.allMafiaIndex.value,
                )
              ],
            ),
          )),
          // Expanded(
          //   child: ListView(
          //     children: [
          //       ...homeCtrl.mafiaList.map((element) => InkWell(
          //             onTap: () {
          //               final index = homeCtrl.mafiaList
          //                   .indexWhere((e) => e.startsWith(element));
          //               print(index);
          //             },
          //             child: CharacterCard(color: red, name: element),
          //           )),
          //       ...homeCtrl.shahrList.map((element) => InkWell(
          //             onTap: () {
          //               final index = homeCtrl.shahrList
          //                   .indexWhere((e) => e.startsWith(element));
          //               print(index);
          //             },
          //             child: CharacterCard(
          //               name: element,
          //               color: green,
          //             ),
          //           )),
          //     ],
          //   ),
          // ),
          Obx(
            () => ChosenCharacterLenght(
              cunter: homeCtrl.playingList.length.toString(),
              title: "${homeCtrl.chosenCharacters.length}/",
            ),
          )
        ],
      ),
    ));
  }
}
