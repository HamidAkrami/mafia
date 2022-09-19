import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/styles.dart';
import 'package:mafia/app/modules/routes/app_routes.dart';

class ChosenPlayerLength extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ChosenPlayerLength({Key? key, this.title, this.cunter}) : super(key: key);
  String? title = "0";
  String? cunter = "0";

  @override
  Widget build(BuildContext context) {
    openDialog() {
      return showDialog(
          context: context,
          builder: (_) {
            return Stack(
              children: [
                Positioned(
                    bottom: Get.width * 0.4,
                    right: 5,
                    child: Text(
                      "تعداد بازیکنان انتخاب شده برای شروع باید بیشتراز 3 نفر باشد",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: redDark),
                    )),
              ],
            );
          });
    }

    return Container(
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
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title!,
                        style: Rstyle().titleStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        cunter!,
                        style: Rstyle().titleStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
                  InkWell(
                    onTap: () {
                      if (homeCtrl.playingList.length < 3) {
                        openDialog();
                      } else {
                        Get.toNamed(AppRoute.characterList);
                      }
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
                        Icons.arrow_forward,
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
