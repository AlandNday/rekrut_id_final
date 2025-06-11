import 'package:get/get.dart';

import '../../../../presentation/job_detail/controllers/job_detail.controller.dart';

class JobDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobDetailController>(
      () => JobDetailController(),
    );
  }
}
