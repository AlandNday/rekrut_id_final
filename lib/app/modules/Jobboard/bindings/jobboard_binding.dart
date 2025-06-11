import 'package:get/get.dart';

import '../controllers/jobboard_controller.dart';

class JobboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobboardController>(
      () => JobboardController(),
    );
  }
}
