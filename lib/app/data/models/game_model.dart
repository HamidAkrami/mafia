import 'package:get/get.dart';

class GameModel {
  int? mafia, heal;
  bool? isRemove, ability, isTargeted;

  String? description, image, role, name;
  GameModel? target, target2;
  GameModel(this.name, this.role, this.mafia, this.isRemove, this.heal,
      this.description, this.image, this.ability, this.isTargeted);
}
