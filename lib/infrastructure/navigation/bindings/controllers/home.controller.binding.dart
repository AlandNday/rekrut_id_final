import 'package:get/get.dart';
import 'package:rekrut_id_final/presentation/Jobboard/controllers/jobboard.controller.dart';

import '../../../../presentation/home/controllers/home.controller.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<JobboardController>(() => JobboardController());
  }
}
