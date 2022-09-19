import 'package:get/get.dart';
import 'package:mafia/app/modules/binding/home_binding.dart';
import 'package:mafia/app/modules/binding/mafia_setting_binding.dart';
import 'package:mafia/app/modules/pages/characters/characters_list.dart';
import 'package:mafia/app/modules/pages/division_of_role.dart/division_of_role.dart';
import 'package:mafia/app/modules/pages/game_page/game_main_page.dart';
import 'package:mafia/app/modules/pages/home/home_page.dart';
import 'package:mafia/app/modules/pages/magia_settings/mafia_setting_page.dart';
import 'package:mafia/app/modules/pages/players/player_list.dart';

class AppRoute {
  static const String homePage = "/homePage";
  static const String playerList = "/playerList";
  static const String characterList = "/characterList";
  static const String mafiaSettingsPage = "/mafiaSettingsPage";
  static const String divisionOfRolePage = "/divisionOfRolePage";
  static const String gamePage = "/gamePage";
}

class App {
  static final pages = [
    GetPage(
        name: AppRoute.homePage,
        page: () => const HomePage(),
        binding: HomePageBinding()),
    GetPage(
        name: AppRoute.playerList,
        page: () => PlayerList(),
        binding: HomePageBinding()),
    GetPage(
      name: AppRoute.characterList,
      page: () => CharacterList(),
    ),
    GetPage(
      name: AppRoute.mafiaSettingsPage,
      page: () => MafiaSettingsPage(),
    ),
    GetPage(
      name: AppRoute.divisionOfRolePage,
      page: () => DivisionOfRole(),
    ),
    GetPage(
      name: AppRoute.gamePage,
      page: () => GamePage(),
    )
  ];
}
