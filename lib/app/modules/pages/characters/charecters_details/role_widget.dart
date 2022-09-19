import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/character_model.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';

class RoleWidget extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  RoleWidget(
      {Key? key, this.color, this.title, this.list1, this.list2, this.index})
      : super(key: key);
  Color? color;
  String? title;
  List<CharacterModel>? list1;
  List<CharacterModel>? list2;
  int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            height: Get.width * 0.12,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: white.withOpacity(0.1)),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 11,
                      ),
                      Text(
                        "نفر",
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$index",
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      title!,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                Expanded(child: Container())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: characterListColumn(list: list1, color: color)),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: characterListColumn(list: list2, color: color),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class characterListColumn extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  characterListColumn({
    Key? key,
    required this.list,
    required this.color,
  }) : super(key: key);

  final List<CharacterModel>? list;
  final Color? color;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...list!.map((e) {
          return InkWell(
            onTap: () {
              if (e.name == "شهروند" && homeCtrl.shahrvandIndex.value == 0) {
                homeCtrl.shahrvandIndex.value++;
                homeCtrl.addShahrvand(e);
              } else if (e.name == "مافیا" && homeCtrl.mafiaIndex.value == 0) {
                homeCtrl.mafiaIndex.value++;
                homeCtrl.addmafia(e);
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 4),
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: Get.width * 0.08,
              width: Get.width,
              color: white.withOpacity(0.1),
              child: e.name == "شهروند" || e.name == "مافیا"
                  ? GestureDetector(
                      onTap: () {
                        if (e.name == "شهروند" &&
                            homeCtrl.shahrvandIndex.value == 0) {
                          homeCtrl.shahrvandIndex.value++;
                          homeCtrl.addShahrvand(e);
                        } else if (e.name == "مافیا" &&
                            homeCtrl.mafiaIndex.value == 0) {
                          homeCtrl.mafiaIndex.value++;
                          homeCtrl.addmafia(e);
                        }
                      },
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.name!,
                              style: TextStyle(color: white),
                            ),
                            e.name == "شهروند" &&
                                    homeCtrl.shahrvandIndex.value == 0
                                ? Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: color!),
                                        borderRadius: BorderRadius.circular(7),
                                        color: black),
                                  )
                                : e.name == "مافیا" &&
                                        homeCtrl.mafiaIndex.value == 0
                                    ? Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: color!),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: black),
                                      )
                                    : Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              homeCtrl.setShahrvand(e);
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1, color: color!),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: color),
                                              child: const Icon(
                                                Icons.add,
                                                color: white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 11,
                                          ),
                                          Text(
                                            e.name == "شهروند"
                                                ? homeCtrl.shahrvandIndex.value
                                                    .toString()
                                                : homeCtrl.mafiaIndex.value
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: e.name == "شهروند"
                                                    ? blueDark
                                                    : redDark,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 11,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (e.name == "شهروند") {
                                                homeCtrl.shahrvandIndex.value--;
                                                homeCtrl.removeCharacter(e);
                                                homeCtrl.allShahrIndex.value--;
                                              } else if (e.name == "مافیا") {
                                                homeCtrl.mafiaIndex.value--;
                                                homeCtrl.removeCharacter(e);
                                                homeCtrl.allMafiaIndex.value--;
                                              }
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1, color: color!),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: color),
                                              child: Icon(
                                                Icons.remove,
                                                color: white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        homeCtrl.onSelectCharacter(e);
                        homeCtrl.addCharacter(e);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              homeCtrl.onSelectCharacter(e);
                              homeCtrl.addCharacter(e);
                            },
                            child: e.isPicked!
                                ? Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: color!),
                                        borderRadius: BorderRadius.circular(7),
                                        color: color),
                                    child: Icon(
                                      Icons.done,
                                      color: white,
                                      size: 18,
                                    ),
                                  )
                                : Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: color!),
                                        borderRadius: BorderRadius.circular(7),
                                        color: black),
                                  ),
                          ),
                          Text(
                            e.name!,
                            style: TextStyle(color: white),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        })
      ],
    );
  }
}
