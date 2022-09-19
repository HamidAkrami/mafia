import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/service/storage/sstorage_service.dart';
import 'package:mafia/app/modules/binding/home_binding.dart';
import 'package:mafia/app/modules/binding/main_binding.dart';
import 'package:mafia/app/modules/pages/home/home_page.dart';
import 'package:mafia/app/modules/routes/app_routes.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: App.pages,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.black,
        primaryColor: red,
        fontFamily: "Vazir",
      ),
      initialRoute: AppRoute.homePage,
      initialBinding: MainBinding(),
    );
  }
}
