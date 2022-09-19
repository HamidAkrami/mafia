import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/modules/pages/styles.dart';
import 'package:mafia/app/modules/pages/widgets/custom_container.dart';

class OptionWidget2 extends StatefulWidget {
  OptionWidget2(
      {Key? key,
      this.selectedItem,
      this.option,
      this.button1,
      this.button2,
      this.selectedIndex = 0})
      : super(key: key);
  ValueChanged<int>? selectedItem;
  int? selectedIndex;
  String? option;
  String? button1;
  String? button2;
  @override
  State<OptionWidget2> createState() => _OptionWidget2State();
}

class _OptionWidget2State extends State<OptionWidget2> {
  int? index;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.selectedIndex!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      height: Get.width * 0.14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                        widget.selectedItem!(index!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                topLeft: Radius.circular(8)),
                            color: index == 0
                                ? blueDark
                                : blueDark.withOpacity(0.1),
                            border: Border.all(
                              width: 1,
                              color: blueDark,
                            )),
                        alignment: Alignment.center,
                        child: Text(widget.button1!,
                            style: index == 0
                                ? TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)
                                : TextStyle(
                                    color: blueDark.withOpacity(0.8),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          index = 1;
                        });
                        widget.selectedItem!(index!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            color: index == 1
                                ? blueDark
                                : blueDark.withOpacity(0.1),
                            border: Border.all(
                              width: 1,
                              color: blueDark,
                            )),
                        alignment: Alignment.center,
                        child: Text(
                          widget.button2!,
                          style: index == 1
                              ? TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)
                              : TextStyle(
                                  color: blueDark.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.option!,
              textAlign: TextAlign.right,
              style: Rstyle().optionStyle,
            ),
          )
        ],
      ),
    );
  }
}
