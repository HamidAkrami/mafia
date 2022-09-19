import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/mafia_player_model.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/players/player_list_details/add_player_widget.dart';
import 'package:mafia/app/modules/pages/players/player_list_details/player_card.dart';
import 'package:mafia/app/modules/pages/players/player_list_details/player_list_header.dart';
import 'package:mafia/app/modules/pages/players/player_list_details/team_number.dart';
import 'package:mafia/app/modules/pages/styles.dart';
import 'package:mafia/app/modules/pages/players/player_list_details/chosen_players_length.dart';
import 'package:mafia/app/modules/pages/widgets/custom_container.dart';
import 'package:mafia/app/modules/pages/widgets/input_widget.dart';
import 'package:mafia/app/modules/routes/app_routes.dart';

class PlayerList extends StatelessWidget {
  PlayerList({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Form(
            key: homeCtrl.formKey,
            child: Column(
              children: [
                PlayerListHeader(),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: GetBuilder<HomeController>(
                    builder: (controller) => Container(
                      child: ListView.builder(
                        itemCount: homeCtrl.playerList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.all(3),
                              alignment: Alignment.centerRight,
                              child: Dismissible(
                                background: Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  padding: EdgeInsets.only(left: 16),
                                  color: Colors.red,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "حذف",
                                    style: Rstyle().nameStyle,
                                  ),
                                ),
                                onDismissed: ((direction) {
                                  homeCtrl
                                      .removePlayer(homeCtrl.playerList[index]);
                                }),
                                key: ObjectKey(homeCtrl.playerList[index]),
                                direction: DismissDirection.startToEnd,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: InkWell(
                                    onTap: () {
                                      homeCtrl.onListItemTap(index);
                                      homeCtrl.addPlayer(
                                          homeCtrl.playerList[index]);
                                      print(homeCtrl.playingList.length);
                                    },
                                    child: PlayerCard(
                                      index: index,
                                      mafiaPlayers: homeCtrl.playerList[index],
                                      name: homeCtrl.playerList[index].name,
                                    ),
                                  ),

                                  //  GestureDetector(
                                  //   onTap: () {
                                  //     homeCtrl.onListItemTap(index);
                                  //     homeCtrl.addPlayer(
                                  //         homeCtrl.playerList[index]);

                                  //     print(homeCtrl.playingList.length);
                                  //   },
                                  //   child:
                                  // ),
                                ),
                              ));
                        },
                      ),
                    ),
                  ),
                )),
                AddPlayerWidget(),
                !isKeyboard
                    ? Obx(
                        () => ChosenPlayerLength(
                            cunter: "${homeCtrl.playingList.length}",
                            title: "نفر انتخاب شده"),
                      )
                    : Container()
              ],
            ),
          )),
    );
  }
}
