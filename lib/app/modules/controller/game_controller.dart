import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/game_model.dart';
import 'package:mafia/app/data/models/target_model.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';

class GameController extends GetxController {
  final homeCtrl = Get.find<HomeController>();
  RxInt index = 0.obs;
  RxBool isRemove = false.obs;
  RxBool isNight = false.obs;
  RxBool isDay = true.obs;
  RxBool roundSleep = false.obs;
  RxBool policeShield = false.obs;
  RxBool dalghakAbility = false.obs;
  RxBool showResult = false.obs;
  RxBool useInquire = false.obs;
  RxInt roundSleepChance = 1.obs;
  RxInt isParley = 1.obs;
  RxInt toinquire = 2.obs;
  RxInt police = 2.obs;
  RxInt dalghak = 1.obs;

  RxBool createList = true.obs;
  List<TargetModel> resultTargets = [];

  GameModel? target2;
  GameModel? target3;
  GameModel? target4;
  Rx<PlayerState>? playerState = PlayerState.paused.obs;
  final gameList = <GameModel>[].obs;
  final nightList = <GameModel>[].obs;
  final playersTarget = <GameModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  getResult() {
    resultTargets.clear();
    for (var i = 0; i < nightList.length; i++) {
      if (!nightList[i].isRemove!) {
        if (nightList[i].target != null) {
          if (nightList[i].target2 != null) {
            resultTargets.add(TargetModel(
                role: nightList[i],
                target: nightList[i].target,
                target2: nightList[i].target2));
          } else {
            resultTargets.add(
                TargetModel(role: nightList[i], target: nightList[i].target!));
          }
        }
      }
    }
  }

  getGameList() {
    if (gameList.length == 0) {
      gameList.addAll(homeCtrl.gamePlayerList
          .where(
            (p0) => p0.role!.contains("خوابگرد"),
          )
          .toList());
      gameList.addAll(
          homeCtrl.gamePlayerList.where((p0) => p0.mafia == 1).toList());
      gameList.addAll(homeCtrl.gamePlayerList
          .where((p0) => p0.mafia != 1 && p0.role != "خوابگرد"));
      update();
    }
  }

  changeRoleIndex(String title) {
    playersTarget.clear();
    if (title == "نقش قبل") {
      if (index > 0) {
        index.value--;
        if (gameList[index.value].mafia == 1 && roundSleep.value == true) {
          for (var i = index.value; i < gameList.length; i++) {
            if (gameList[index.value].mafia == 1 && roundSleep.value == true) {
              index.value--;
            }
          }
          print(index.value);
        } else if (gameList[index.value].mafia == 0 && dalghakAbility.value) {
          for (var i = 0; i < gameList.length; i++) {
            if (gameList[index.value].mafia == 0 && dalghakAbility.value) {
              index.value--;
            }
          }
        }
      } else {
        return;
      }
    } else {
      if (title == "دیدن نتایج") {
        getResult();

        showResult.value = true;
      } else if (title == "نقش بعد") {
        playersTarget.clear();
        if (nightList.length > index.value) {
          index.value++;
          for (var i = 0; i < nightList.length; i++) {
            nightList[i].isTargeted = false;
          }
          if (gameList[index.value].mafia == 1 && roundSleep.value) {
            for (var i = index.value; i < gameList.length; i++) {
              if (gameList[index.value].mafia == 1 && roundSleep.value) {
                index.value++;
              }
            }
          } else if (gameList[index.value].mafia == 0 && dalghakAbility.value) {
            for (var i = 0; i < gameList.length; i++) {
              if (gameList[index.value].mafia == 0 && dalghakAbility.value) {
                index.value++;
              }
            }
          }
        }
      }
    }
  }

  removeMafia(GameModel mafia) {
    if (roundSleep.value) {
      gameList.remove(mafia);
    } else {
      return;
    }
    update();
    gameList.refresh();
  }

  List<GameModel> targets(name) {
    List<GameModel> targetList = [];

    if (name == "پدرخوانده") {}
    targetList.addAll(
        homeCtrl.gamePlayerList.where((p0) => p0.role != name).toList());
    return targetList;
  }

  reorderNightList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    GameModel player = gameList.removeAt(oldIndex);
    gameList.insert(newIndex, player);
    update();
    gameList.refresh();
  }

  targetPlayer(GameModel player) {
    player.isTargeted = !player.isTargeted!;
    print(player.isTargeted);
    update();
  }

  submitTarget(GameModel player) {
    playersTarget.clear();
    for (var i = 0; i < homeCtrl.gamePlayerList.length; i++) {
      if (homeCtrl.gamePlayerList[i].isTargeted!) {
        playersTarget.add(homeCtrl.gamePlayerList[i]);
      }
    }
    if (playersTarget.isNotEmpty) {
      player.target = playersTarget[0];
      if (playersTarget.length > 1) {
        player.target2 = playersTarget[1];
      } else {
        player.target2 = null;
      }
    } else {
      player.target = null;
    }

    Get.back();
    update();
  }

  cancelTarget(GameModel player) {
    for (var i = 0; i < homeCtrl.gamePlayerList.length; i++) {
      if (homeCtrl.gamePlayerList[i].isTargeted!) {
        nightList[i].isTargeted = false;
        player.target = null;
        player.target2 = null;
      }
    }
    update();
  }

  reorderPlayerList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    GameModel player = homeCtrl.gamePlayerList.removeAt(oldIndex);
    homeCtrl.gamePlayerList.insert(newIndex, player);
    update();
  }

  killPlayer(GameModel player) {
    player.isRemove = !player.isRemove!;
    update();
  }

  itsDay() {
    if (!isDay.value) {
      isDay.value = true;
      isNight.value = false;
    }
    update();
  }

  itsNight() {
    if (isDay.value) {
      isNight.value = true;
      isDay.value = false;
      index.value == 0;
      getGameList();
    }
    update();
  }

  roleTarget({GameModel? role1, GameModel? role2}) {
    if (role1!.role == "اسنایپر") {
      if (role2!.mafia == 0) {
        role1.heal = role1.heal! - 1;
      } else {
        role2.heal = role2.heal! - 1;
      }
    } else if (role1.mafia == 1) {
      role2!.heal = role2.heal! - 1;
    } else if (role1.role!.contains("دکتر")) {
      role2!.heal = role2.heal! + 1;
    }
  }
}
