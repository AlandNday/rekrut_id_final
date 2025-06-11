import 'package:get/get.dart';

import '../modules/Jobboard/bindings/jobboard_binding.dart';
import '../modules/Jobboard/views/jobboard_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOMEPAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => const HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.JOBBOARD,
      page: () => const JobboardView(),
      binding: JobboardBinding(),
    ),
  ];
}
