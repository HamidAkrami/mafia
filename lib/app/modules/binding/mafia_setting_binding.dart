import 'package:get/get.dart';
import 'package:mafia/app/data/provider/provider.dart';
import 'package:mafia/app/data/service/storage/repository.dart';
import 'package:mafia/app/modules/controller/home_controller.dart';

class MafiaSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
        mafiaRepository: MafiaRepository(mafiaProvider: MafiaProvider())));
  }
}
