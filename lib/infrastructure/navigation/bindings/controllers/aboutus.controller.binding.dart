import 'package:get/get.dart';

import '../../../../presentation/aboutus/controllers/aboutus.controller.dart';

class AboutusControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutusController>(
      () => AboutusController(),
    );
  }
}
