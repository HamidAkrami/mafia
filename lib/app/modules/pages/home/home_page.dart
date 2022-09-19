import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/pages/players/player_list.dart';
import 'package:mafia/app/modules/pages/styles.dart';
import 'package:mafia/app/modules/pages/widgets/custom_container.dart';
import 'package:mafia/app/modules/routes/app_routes.dart';

import '../../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: Column(
          children: [
            CustomContainer(
              width: Get.width,
              height: Get.height * 0.09,
              color: white.withOpacity(0.1),
              text: "مافی ها",
              style: Rstyle().titleStyle,
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoute.mafiaSettingsPage);
                            },
                            child: CustomContainer(
                              color: greenDark,
                              width: Get.width * 0.6,
                              height: Get.height * 0.09,
                              text: "شروع بازی",
                              style: Rstyle().nameStyle,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomContainer(
                            border: 1,
                            color: grey.withOpacity(0.3),
                            width: Get.width * 0.6,
                            height: Get.height * 0.09,
                            text: "آموزش بازی",
                            style: Rstyle().nameStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomContainer(
                            border: 1,
                            color: grey.withOpacity(0.3),
                            width: Get.width * 0.6,
                            height: Get.height * 0.09,
                            text: "نقش ها",
                            style: Rstyle().nameStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomContainer(
                            border: 1,
                            color: grey.withOpacity(0.3),
                            width: Get.width * 0.6,
                            height: Get.height * 0.09,
                            text: "نقش های تصادفی",
                            style: Rstyle().nameStyle,
                          ),
                        ],
                      ),
                    ))),
            Container(
              alignment: Alignment.centerRight,
              width: Get.width,
              child: InkWell(
                onTap: () {
                  controller.muteMusic();
                },
                child: Obx(
                  (() => Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 20, right: 20),
                        width: Get.width * 0.15,
                        height: Get.width * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: grey.withOpacity(0.3),
                            border: Border.all(
                                width: 1, color: white.withOpacity(0.6))),
                        child: Image.asset(!controller.isMute.value
                            ? "assets/images/music.png"
                            : "assets/images/mute.png"),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
