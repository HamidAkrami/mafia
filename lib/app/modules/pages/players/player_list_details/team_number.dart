import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';

class TeamNumber extends StatelessWidget {
  TeamNumber({Key? key, this.number, this.color, this.ontap}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  String? number;
  Function? ontap;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap;
        print(homeCtrl.shahrNum.value);
        print(homeCtrl.mafiaNum.value);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        height: Get.height * 0.05,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.center,
        child: Text(number!),
      ),
    );
  }
}
