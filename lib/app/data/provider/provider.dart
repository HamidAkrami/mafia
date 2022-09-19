import 'dart:convert';

import 'package:get/get.dart';
import 'package:mafia/app/core/utils/key.dart';
import 'package:mafia/app/data/models/mafia_player_model.dart';
import 'package:mafia/app/data/service/storage/sstorage_service.dart';

class MafiaProvider {
  final _storage = Get.find<StorageService>();
  List<MafiaPlayers> readPlayers() {
    var players = <MafiaPlayers>[];
    jsonDecode(_storage.read(playerKey).toString())
        .forEach((e) => players.add(MafiaPlayers.fromJson(e)));
    return players;
  }

  void writePlayers(List<MafiaPlayers> players) {
    _storage.write(playerKey, jsonEncode(players));
  }
}
