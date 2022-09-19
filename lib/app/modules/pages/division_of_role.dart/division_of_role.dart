import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/styles.dart';
import 'package:mafia/app/modules/routes/app_routes.dart';

class DivisionOfRole extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final gameCtrl = Get.find<GameController>();
  DivisionOfRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    openDialog(int index) {
      return showDialog(
          context: context,
          builder: (_) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                backgroundColor: black,
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 34, 34, 34)),
                  height: Get.width * 1.3,
                  width: Get.width * 0.8,
                  child: Column(
                    children: [
                      Image.asset(homeCtrl.gamePlayerList.last.image!),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${homeCtrl.gamePlayerList.last.name!} : ${homeCtrl.gamePlayerList.last.role} ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: homeCtrl.gamePlayerList.last.mafia == 1
                                ? redDark
                                : blueDark,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        homeCtrl.gamePlayerList.last.mafia == 0
                            ? "(گروه شهروند)"
                            : "(گروه مافیا)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: homeCtrl.gamePlayerList.last.mafia == 1
                                ? redDark
                                : blueDark,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        homeCtrl.gamePlayerList.last.description!,
                        style: TextStyle(fontSize: 12, color: white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: black,
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<HomeController>(builder: (controller) {
              return homeCtrl.finalPlayerList.isNotEmpty
                  ? Container(
                      alignment: Alignment.center,
                      height: Get.height,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.6,
                          ),
                          itemCount: homeCtrl.finalPlayerList.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                                onTap: () {
                                  homeCtrl.divisionOfRole(
                                      homeCtrl.finalPlayerList[index]);

                                  openDialog(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: FittedBox(
                                    child: Text(
                                      homeCtrl.finalPlayerList[index].name!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: white),
                                    ),
                                  ),
                                ));
                          })))
                  : Column(
                      children: [
                        const Expanded(child: SizedBox()),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: Get.width * 0.9,
                          height: Get.width * 0.4,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 44, 44, 44),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "پخش کردن نقش ها به پایان رسید",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                        onTap: () {
                                          homeCtrl.addTofinalList();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 10),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: redDark,
                                          ),
                                          child: const Text(
                                            "نقش دهی دوباره",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                        onTap: () {
                                          Get.offNamed(AppRoute.gamePage);
                                          homeCtrl.unSelectAllPlayer();
                                          homeCtrl.shahrvandIndex.value = 0;
                                          homeCtrl.mafiaIndex.value = 0;
                                          homeCtrl.allMafiaIndex.value = 0;
                                          homeCtrl.allShahrIndex.value = 0;
                                          homeCtrl.chosenCharacters.clear();
                                          gameCtrl.isDay.value = true;
                                          gameCtrl.isNight.value = false;
                                          gameCtrl.gameList.clear();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 10),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: greenDark,
                                          ),
                                          child: const Text(
                                            "ورود به بازی",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    );
            }),
          ),
          Container(
            height: Get.height * 0.09,
            color: white.withOpacity(0.1),
            child: Column(
              children: [
                Container(
                  height: 1,
                  color: white.withOpacity(0.15),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            width: Get.width * 0.15,
                            height: Get.width * 0.09,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: white.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(5),
                                color: white.withOpacity(0.12)),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.arrow_back,
                              color: white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            for (var i = 0;
                                i < homeCtrl.chosenCharacters.length;
                                i++) {}

                            if (homeCtrl.checkMafiaIndex()) {
                              Get.toNamed(AppRoute.divisionOfRolePage);
                            } else {
                              return;
                            }
                            homeCtrl.addTofinalList();
                          },
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              width: Get.width * 0.15,
                              height: Get.width * 0.09,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: white.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(5),
                                  color: white.withOpacity(0.12)),
                              alignment: Alignment.center,
                              child: Image.asset("assets/images/refresh.png")),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
