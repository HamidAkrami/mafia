import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/provider/provider.dart';
import 'package:mafia/app/data/service/storage/repository.dart';
import 'package:mafia/app/modules/pages/styles.dart';

import '../../controller/home_controller.dart';

class InputWidget extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  InputWidget({Key? key, this.text, this.textEditingController})
      : super(key: key);
  String? text;
  TextEditingController? textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white.withOpacity(0.11),
      height: Get.width * 0.11,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                validator: ((value) {
                  if (value == null || value.trim().isEmpty) {
                    return "لطفا نام را وارد کنید";
                  }
                  return null;
                }),
                controller: textEditingController,
                style: TextStyle(color: white),
                cursorColor: greenDark,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsetsDirectional.only(bottom: 15, start: 12),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: white.withOpacity(0.6))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: white.withOpacity(0.6))),
                  labelStyle: TextStyle(
                      color: white.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  labelText: text,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
