import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';

class LimitedCharacters extends StatelessWidget {
  final gameCtrl = Get.find<GameController>();
  final homeCtrl = Get.find<HomeController>();
  LimitedCharacters({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Column(
        children: [
          Column(
            children: [
              Text(
                gameCtrl.nightList[gameCtrl.index.value].role == "خوابگرد"
                    ? "آیا خوابگرد از قابلیت خود استفاده میکند؟"
                    : gameCtrl.nightList[gameCtrl.index.value].role ==
                            "رویئین تن"
                        ? "آیا رویین تن استعلام می گیرد؟"
                        : gameCtrl.nightList[gameCtrl.index.value].role ==
                                "پلیس"
                            ? "آیا پلیس امشب هوشیار است؟"
                            : gameCtrl.nightList[gameCtrl.index.value].role ==
                                    "دلقک"
                                ? "آیا دلقک از قابلیت خود استفاده میکند؟"
                                : "",
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                gameCtrl.nightList[gameCtrl.index.value].role == "خوابگرد"
                    ? "1 :تعداد فرصت"
                    : gameCtrl.nightList[gameCtrl.index.value].role ==
                            "رویئین تن"
                        ? "${gameCtrl.toinquire.value} :تعداد فرصت"
                        : gameCtrl.nightList[gameCtrl.index.value].role ==
                                "پلیس"
                            ? "${gameCtrl.police.value} :تعداد فرصت"
                            : gameCtrl.nightList[gameCtrl.index.value].role ==
                                    "دلقک"
                                ? "${gameCtrl.dalghak.value} :تعداد فرصت"
                                : "",
                style: TextStyle(
                    color: white, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YesOrNo(
                  title: "خیر",
                  onPress: () {
                    gameCtrl.nightList[gameCtrl.index.value].role == "خوابگرد"
                        ? selectedNo("خوابگرد")
                        : gameCtrl.nightList[gameCtrl.index.value].role ==
                                "روئین تن"
                            ? selectedNo("رویین تن")
                            : gameCtrl.nightList[gameCtrl.index.value].role ==
                                    "پلیس"
                                ? selectedNo("پلیس")
                                : gameCtrl.nightList[gameCtrl.index.value]
                                            .role ==
                                        "دلقک"
                                    ? selectedNo("دلقک")
                                    : null;
                  }),
              const SizedBox(
                width: 10,
              ),
              YesOrNo(
                  title: "بله",
                  onPress: () {
                    gameCtrl.nightList[gameCtrl.index.value].role == "خوابگرد"
                        ? selectedYes(context, "خوابگرد")
                        : gameCtrl.nightList[gameCtrl.index.value].role ==
                                "روئین تن"
                            ? selectedYes(context, "رویین تن")
                            : gameCtrl.nightList[gameCtrl.index.value].role ==
                                    "پلیس"
                                ? selectedYes(context, "پلیس")
                                : gameCtrl.nightList[gameCtrl.index.value]
                                            .role ==
                                        "دلقک"
                                    ? selectedYes(context, "دلقک")
                                    : null;
                  }),
            ],
          )
        ],
      )
    ]));
  }

  selectedNo(String role) {
    if (role == "خوابگرد" && gameCtrl.roundSleepChance.value > 0) {
      gameCtrl.index.value++;
      gameCtrl.roundSleep.value = false;
    } else if (role == "پلیس") {
      gameCtrl.policeShield.value = false;
      gameCtrl.index.value++;

      if (gameCtrl.nightList.length - 1 > gameCtrl.index.value) {
        if (gameCtrl.gameList[gameCtrl.index.value].mafia == 1 &&
            gameCtrl.roundSleep.value) {
          for (var i = gameCtrl.index.value;
              i < gameCtrl.gameList.length;
              i++) {
            if (gameCtrl.gameList[gameCtrl.index.value].mafia == 1 &&
                gameCtrl.roundSleep.value) {
              gameCtrl.index.value++;
            }
          }
        }
      }
    } else if (role == "دلقک") {
      gameCtrl.dalghakAbility.value = false;
      gameCtrl.index.value++;
    }

    print(gameCtrl.index.value);
  }

  selectedYes(context, String role) {
    gameCtrl.index.value++;
    print(gameCtrl.index.value);
    if (role == "خوابگرد") {
      gameCtrl.roundSleep.value = true;

      if (gameCtrl.gameList[gameCtrl.index.value].mafia == 1 &&
          gameCtrl.roundSleep.value) {
        for (var i = gameCtrl.index.value; i < gameCtrl.gameList.length; i++) {
          if (gameCtrl.gameList[gameCtrl.index.value].mafia == 1 &&
              gameCtrl.roundSleep.value) {
            gameCtrl.index.value++;
          }
        }
      }
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              backgroundColor: Color.fromARGB(255, 29, 29, 29),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                height: Get.width * 0.5,
                width: Get.width * 0.5,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "خوابگرد امشب بیدار است و مافیا جرات حمله به شهر را ندارد",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: blueDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          height: Get.width * 0.09,
                          width: Get.width * 0.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromARGB(255, 29, 29, 29),
                              border: Border.all(width: 1, color: blueDark)),
                          child: Text(
                            "متوجه شدم",
                            style: TextStyle(
                              color: blueDark,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            );
          });
    } else if (role == "پلیس") {
      gameCtrl.policeShield.value = true;
      if (gameCtrl.nightList.length - 1 > gameCtrl.index.value) {
        if (gameCtrl.gameList[gameCtrl.index.value].mafia == 1 &&
            gameCtrl.roundSleep.value) {
          for (var i = gameCtrl.index.value;
              i < gameCtrl.gameList.length;
              i++) {
            if (gameCtrl.gameList[gameCtrl.index.value].mafia == 1 &&
                gameCtrl.roundSleep.value) {
              gameCtrl.index.value++;
            }
          }
        }
      }
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              backgroundColor: Color.fromARGB(255, 29, 29, 29),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                height: Get.width * 0.5,
                width: Get.width * 0.5,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "پلیس امشب هوشیار است",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: blueDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          height: Get.width * 0.09,
                          width: Get.width * 0.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromARGB(255, 29, 29, 29),
                              border: Border.all(width: 1, color: blueDark)),
                          child: Text(
                            "متوجه شدم",
                            style: TextStyle(
                              color: blueDark,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            );
          });
    } else if (role == "روئین تن") {
      gameCtrl.showResult.value = true;
      print(gameCtrl.index.value);
      print(gameCtrl.nightList.length);

      gameCtrl.useInquire.value = true;
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              backgroundColor: Color.fromARGB(255, 29, 29, 29),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                height: Get.width * 0.5,
                width: Get.width * 0.5,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "روئین تن استعلام گرفت",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: blueDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          height: Get.width * 0.09,
                          width: Get.width * 0.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromARGB(255, 29, 29, 29),
                              border: Border.all(width: 1, color: blueDark)),
                          child: Text(
                            "متوجه شدم",
                            style: TextStyle(
                              color: blueDark,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            );
          });
    } else if (role == "دلقک") {
      gameCtrl.dalghakAbility.value = true;
      if (gameCtrl.gameList[gameCtrl.index.value].mafia == 0 &&
          gameCtrl.dalghakAbility.value) {
        for (var i = gameCtrl.index.value; i < gameCtrl.gameList.length; i++) {
          if (gameCtrl.gameList[gameCtrl.index.value].mafia == 0 &&
              gameCtrl.dalghakAbility.value) {
            gameCtrl.index.value++;
          }
        }
      }
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
                backgroundColor: Color.fromARGB(255, 29, 29, 29),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  height: Get.width * 0.5,
                  width: Get.width * 0.5,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "دلقک امشب از قدرت خود استفاده کرد و شهروندان امشب بیدار نمیشوند",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: redDark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            height: Get.width * 0.09,
                            width: Get.width * 0.4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromARGB(255, 29, 29, 29),
                                border: Border.all(width: 1, color: blueDark)),
                            child: Text(
                              "متوجه شدم",
                              style: TextStyle(
                                color: blueDark,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  ),
                ));
          });
    }
  }
}

class YesOrNo extends StatelessWidget {
  final gameCtrl = Get.find<GameController>();
  VoidCallback? onPress;
  String? title;

  YesOrNo({
    required this.onPress,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), color: white),
        alignment: Alignment.center,
        height: Get.width * 0.09,
        width: Get.width * 0.24,
        child: Text(
          title!,
          style: TextStyle(color: black, fontSize: 18),
        ),
      ),
    );
  }
}
