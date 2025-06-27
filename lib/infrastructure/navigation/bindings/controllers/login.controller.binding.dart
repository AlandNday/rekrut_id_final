import 'package:get/get.dart';
import 'package:rekrut_id_final/presentation/home/controllers/home.controller.dart';

import '../../../../presentation/login/controllers/login.controller.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
