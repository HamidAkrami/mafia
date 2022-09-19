import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/styles.dart';

class RemovePlayersDialog extends StatelessWidget {
  const RemovePlayersDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    openDialog() {
      return showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 29, 28, 28),
                ),
                height: Get.width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "آیا مایل به حذف همه بازیکنان هستید؟",
                      textAlign: TextAlign.center,
                      style: Rstyle().titleStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: chosenWIdget(
                          color: redDark,
                          title: "خیر",
                        )),
                        const SizedBox(
                          width: 50,
                        ),
                        Expanded(
                            child: chosenWIdget(
                          color: greenDark,
                          title: "بله",
                        )),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }

    return InkWell(
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
      onTap: () {
        openDialog();
      },
    );
  }
}

class chosenWIdget extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  String? title;
  Color? color;
  chosenWIdget({
    this.color,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == "خیر") {
          Get.back();
        } else {
          homeCtrl.removePlayerList();

          Get.back();
        }
      },
      child: Container(
        height: Get.width * 0.1,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        child: Text(
          title!,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: white),
        ),
      ),
    );
  }
}
