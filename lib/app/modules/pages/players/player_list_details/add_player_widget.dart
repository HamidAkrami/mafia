import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';
import 'package:mafia/app/modules/pages/widgets/input_widget.dart';

class AddPlayerWidget extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: white.withOpacity(0.15),
        ),
        Container(
          padding: EdgeInsets.all(12),
          height: Get.width * 0.2,
          color: white.withOpacity(0.09),
          child: Row(
            children: [
              Container(
                height: 1,
                color: white.withOpacity(0.15),
              ),
              GestureDetector(
                onTap: () {
                  homeCtrl.addNewPlayer(
                      homeCtrl.playerNameController!.text, true);
                },
                child: Container(
                  width: Get.width * 0.15,
                  height: Get.width * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: greenDark,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.add,
                    size: 45,
                    color: white,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 5,
                  child: InputWidget(
                    textEditingController: homeCtrl.playerNameController,
                    text: "بازیکن جدید",
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
