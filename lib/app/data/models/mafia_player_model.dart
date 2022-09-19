import 'package:flutter/material.dart';

class MafiaPlayers {
  String? name;
  bool? isPlay;

  MafiaPlayers({this.name, this.isPlay});

  MafiaPlayers copyWith({String? name, bool? isplay}) => MafiaPlayers(
        name: name ?? this.name,
        isPlay: isPlay ?? this.isPlay,
      );

  factory MafiaPlayers.fromJson(Map<String, dynamic> json) =>
      MafiaPlayers(name: json["name"], isPlay: json["isPlay"]);
  Map<String, dynamic> toJson() => {"name": name!, "isPlay": isPlay!};
}
