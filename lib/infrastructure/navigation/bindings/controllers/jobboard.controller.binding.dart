import 'package:get/get.dart';

import '../../../../presentation/Jobboard/controllers/jobboard.controller.dart';

class JobboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobboardController>(
      () => JobboardController(),
    );
  }
}
