import 'package:get/get.dart';
import 'package:mafia/app/data/provider/provider.dart';
import 'package:mafia/app/data/service/storage/repository.dart';
import 'package:mafia/app/modules/binding/mafia_setting_binding.dart';
import 'package:mafia/app/modules/controller/game_controller.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(
        mafiaRepository: MafiaRepository(mafiaProvider: MafiaProvider())));
    Get.put(GameController());
    // Get.lazyPut<HomeController>(() => HomeController(
    //     mafiaRepository: MafiaRepository(mafiaProvider: MafiaProvider())));
  }
}
