import 'package:get/get.dart';

import '../../../../presentation/contactus/controllers/contactus.controller.dart';

class ContactusControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactusController>(
      () => ContactusController(),
    );
  }
}
