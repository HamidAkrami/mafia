import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/magia_settings/settings_details/options_widget.dart';
import 'package:mafia/app/modules/pages/styles.dart';
import 'package:mafia/app/modules/pages/widgets/custom_container.dart';
import 'package:mafia/app/modules/routes/app_routes.dart';

class MafiaSettingsPage extends GetView<HomeController> {
  final homeCtrl = Get.find<HomeController>();
  MafiaSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: black,
      body: Column(children: [
        CustomContainer(
          width: Get.width,
          height: Get.height * 0.09,
          color: white.withOpacity(0.1),
          text: "تنظیمات بازی",
          style: Rstyle().titleStyle,
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  children: [
                    OptionWidget2(
                        selectedIndex: controller.roleDistribution,
                        option: "پخش نقش ها",
                        button1: "دستی",
                        button2: "تصادفی",
                        selectedItem: controller.selectDistributionOfRole),
                    OptionWidget2(
                        selectedIndex: controller.neutralGroup,
                        option: "گروه بی طرف",
                        button1: "نداریم",
                        button2: "داریم",
                        selectedItem: controller.selectNeutralGroup),
                    OptionWidget2(
                        selectedIndex: controller.musicAtNight,
                        selectedItem: controller.selectMusicAtNight,
                        option: "موسیقی هنگام شب",
                        button1: "نداریم",
                        button2: "داریم"),
                    OptionWidget2(
                        selectedIndex: controller.roleInNight,
                        selectedItem: controller.selectRoleInNight,
                        option: "نقش ها در شب",
                        button1: "دستی",
                        button2: "نوبتی")
                  ],
                ))),
        Padding(
          padding: const EdgeInsets.all(11),
          child: InkWell(
            onTap: () {
              homeCtrl.addToPlayingList();
              Get.toNamed(AppRoute.playerList);
            },
            child: CustomContainer(
              width: Get.width,
              height: Get.width * 0.14,
              text: "ذخیره و ادامه",
              color: greenDark,
              style: Rstyle().nameStyle,
            ),
          ),
        )
      ]),
    ));
  }
}
