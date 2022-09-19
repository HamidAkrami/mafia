import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/game_model.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/game_page/night_page/night_page_details/ability_target_dialog.dart';

import 'limited_character_widget.dart';

class NightDialogWidget extends StatelessWidget {
  final gameCtrl = Get.find<GameController>();
  final homeCtrl = Get.find<HomeController>();
  NightDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Obx(
        () => Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: Colors.transparent,
          child: gameCtrl.showResult.value ||
                  gameCtrl.index.value > gameCtrl.nightList.length
              ? Result(
                  controller: gameCtrl,
                )
              : SizedBox(
                  height: Get.width * 1.4,
                  child: Column(
                    children: [
                      Expanded(
                        child: GetBuilder<GameController>(
                          builder: (controller) =>
                              characterPowerView(controller: gameCtrl),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: Row(
                          children: [
                            ChangeRole(
                                onPress: () =>
                                    gameCtrl.changeRoleIndex("نقش قبل"),
                                title: "نقش قبل"),
                            const SizedBox(
                              width: 18,
                            ),
                            ChangeRole(
                              onPress: () => gameCtrl.changeRoleIndex(
                                gameCtrl.nightList.length - 1 >
                                        gameCtrl.index.value
                                    ? "نقش بعد"
                                    : "دیدن نتایج",
                              ),
                              title: gameCtrl.nightList.length - 1 >
                                      gameCtrl.index.value
                                  ? "نقش بعد"
                                  : "دیدن نتایج",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  Result({
    Key? key,
    this.controller,
  }) {
    controller!.getResult();
  }

  GameController? controller;
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.width * 1.5,
        color: Color(0xff191919),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            const Text(
              "گزارش شب",
              style: TextStyle(color: white, fontSize: 18),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: Get.width,
              height: 0.5,
              color: white.withOpacity(0.5),
            ),
            const SizedBox(
              height: 12,
            ),
            controller!.policeShield.value
                ? const Text(
                    "پلیس در شب هوشیار بود",
                    style: TextStyle(color: white, fontSize: 14),
                    textAlign: TextAlign.right,
                  )
                : Container(),
            const SizedBox(
              height: 12,
            ),
            controller!.useInquire.value
                ? const Text(
                    "روئین تن استعلام گرفت",
                    style: TextStyle(color: white, fontSize: 14),
                    textAlign: TextAlign.right,
                  )
                : Container(),
            controller!.roundSleep.value
                ? const Text(
                    "خوابگرد خود را فدای شهر کرد و کشته شد",
                    style: TextStyle(color: white, fontSize: 14),
                    textAlign: TextAlign.right,
                  )
                : Container(),
            controller!.dalghakAbility.value
                ? const Text(
                    "دلقک از قدرت خود استفاده کرد و به مافیای ساده تبدیل شد",
                    style: TextStyle(color: white, fontSize: 14),
                    textAlign: TextAlign.right,
                  )
                : Container(),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: Get.width,
              height: 0.5,
              color: white.withOpacity(0.5),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: controller!.resultTargets.length,
                  itemBuilder: ((context, index) => TargetWidget(
                        controller: controller,
                        index: index,
                      ))),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                controller!.useInquire.value = false;
                controller!.dalghakAbility.value = false;
                controller!.policeShield.value = false;
                controller!.roundSleep.value = false;
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                height: Get.width * 0.12,
                width: Get.width * 0.6,
                decoration: BoxDecoration(
                    color: green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 0.8, color: green)),
                child: Text(
                  "متوجه شدم",
                  style: TextStyle(
                      color: white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ));
  }
}

class TargetWidget extends StatelessWidget {
  TargetWidget({Key? key, required this.controller, required this.index})
      : super(key: key);

  final GameController? controller;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: Get.width * 0.11,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              children: [
                controller!.resultTargets[index].target2 == null
                    ? Container()
                    : Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 0.7,
                                color: controller!.resultTargets[index].target2!
                                            .mafia ==
                                        0
                                    ? blueDark
                                    : redDark,
                              )),
                          child:
                              controller!.resultTargets[index].target2 == null
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: FittedBox(
                                        child: Text(
                                            "(${controller!.resultTargets[index].target2!.role!})${controller!.resultTargets[index].target2!.name!}",
                                            style: TextStyle(
                                              color: controller!
                                                          .resultTargets[index]
                                                          .target2!
                                                          .mafia ==
                                                      0
                                                  ? blueDark
                                                  : red,
                                              fontSize: 12,
                                            )),
                                      ),
                                    ),
                        ),
                      ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 0.7,
                          color:
                              controller!.resultTargets[index].target!.mafia ==
                                      0
                                  ? blueDark
                                  : redDark,
                        )),
                    child: FittedBox(
                      child: Text(
                          "(${controller!.resultTargets[index].target!.role!})${controller!.resultTargets[index].target!.name!}",
                          style: TextStyle(
                            color: controller!
                                        .resultTargets[index].target!.mafia ==
                                    0
                                ? blueDark
                                : red,
                            fontSize: 13,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.arrow_back,
            color: white,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 0.7,
                    color: controller!.resultTargets[index].role!.mafia == 0
                        ? blueDark
                        : redDark,
                  )),
              child: FittedBox(
                child: Text(
                    "(${controller!.resultTargets[index].role!.name!}) ${controller!.resultTargets[index].role!.role!}",
                    style: TextStyle(
                      color: controller!.resultTargets[index].role!.mafia == 0
                          ? blueDark
                          : red,
                      fontSize: 13,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class characterPowerView extends StatelessWidget {
  characterPowerView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final GameController controller;
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromARGB(255, 37, 37, 37),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: Get.width * 0.5,
            width: Get.width * 0.5,
            child: Image.asset(
              controller.nightList[controller.index.value].image!,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            controller.nightList[controller.index.value].role!,
            style: TextStyle(
                color: controller.nightList[controller.index.value].isRemove!
                    ? grey
                    : controller.nightList[controller.index.value].mafia == 0
                        ? blueDark
                        : redDark,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          Text(
            controller.nightList[controller.index.value].mafia == 0
                ? "(گروه شهروند)"
                : "(گروه مافیا)",
            style: TextStyle(
                fontSize: 14,
                color: controller.nightList[controller.index.value].isRemove!
                    ? grey
                    : controller.nightList[controller.index.value].mafia == 0
                        ? blueDark
                        : redDark),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          controller.playersTarget.isNotEmpty
              ? SizedBox(
                  height: 28,
                  width: 28,
                  child: Image.asset(
                    "assets/images/arrowdown.png",
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          const Expanded(
            child: SizedBox(),
          ),
          controller.nightList[controller.index.value].role == "خوابگرد" ||
                  controller.nightList[controller.index.value].role ==
                      "روئین تن" ||
                  controller.nightList[controller.index.value].role == "پلیس" ||
                  controller.nightList[controller.index.value].role == "دلقک"
              ? Container()
              : controller.nightList[controller.index.value].target != null &&
                      controller.nightList[controller.index.value].target2 !=
                          null
                  ? Column(
                      children: [
                        TargetedPlayer(
                            player: controller
                                .nightList[controller.index.value].target),
                        const SizedBox(
                          height: 8,
                        ),
                        TargetedPlayer(
                            player: controller
                                .nightList[controller.index.value].target2)
                      ],
                    )
                  : controller.nightList[controller.index.value].target != null
                      ? TargetedPlayer(
                          player: controller
                              .nightList[controller.index.value].target)
                      : Container(),
          const SizedBox(
            height: 12,
          ),
          controller.nightList[controller.index.value].role == "خوابگرد" ||
                  controller.nightList[controller.index.value].role ==
                      "روئین تن" ||
                  controller.nightList[controller.index.value].role == "پلیس" ||
                  controller.nightList[controller.index.value].role == "دلقک"
              ? LimitedCharacters()
              : InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Dialog(
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              backgroundColor: Colors.transparent,
                              child: AbilityTargetDialog(
                                  player: controller
                                      .nightList[controller.index.value]),
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: Get.width * 0.3,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          controller.nightList[controller.index.value].isRemove!
                              ? grey
                              : controller.nightList[controller.index.value]
                                          .mafia ==
                                      0
                                  ? blueDark.withOpacity(0.1)
                                  : redDark.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        width: 1,
                        color: controller
                                .nightList[controller.index.value].isRemove!
                            ? grey
                            : controller.nightList[controller.index.value]
                                        .mafia ==
                                    0
                                ? blueDark
                                : redDark,
                      ),
                    ),
                    child: Text(
                      controller.nightList[controller.index.value].target ==
                              null
                          ? " انتخاب"
                          : "تغییر",
                      style: const TextStyle(fontSize: 14, color: white),
                    ),
                  ),
                ),
          controller.playersTarget.isNotEmpty
              ? SizedBox(
                  height: 20,
                )
              : Expanded(child: SizedBox())
        ],
      ),
    );
  }
}

class TargetedPlayer extends StatelessWidget {
  final gameCtrl = Get.find<GameController>();
  GameModel? player;
  TargetedPlayer({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.09,
      width: Get.width * 0.4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: player!.mafia == 0 ? blueDark : redDark,
        ),
        color: player!.mafia == 0
            ? blueDark.withOpacity(0.01)
            : redDark.withOpacity(0.01),
      ),
      child: Text(
        "(${player!.name}) ${player!.role!}",
        style: TextStyle(
            color: player!.mafia == 0
                ? blueDark.withOpacity(0.9)
                : redDark.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ChangeRole extends StatelessWidget {
  final gameCtrl = Get.find<GameController>();
  VoidCallback? onPress;
  String? title;
  ChangeRole({
    required this.onPress,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 29, 29, 29),
            borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
        child: Text(
          title!,
          style: TextStyle(
              fontSize: 16,
              color: title == "نقش بعد"
                  ? white
                  : title == "دیدن نتایج"
                      ? greenDark
                      : gameCtrl.index.value == 0
                          ? grey
                          : white),
        ),
      ),
    ));
  }
}
