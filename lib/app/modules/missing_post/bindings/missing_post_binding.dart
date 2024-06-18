import 'package:get/get.dart';

import '../controllers/missing_post_controller.dart';

class MissingPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MissingPostController>(
      () => MissingPostController(),
    );
  }
}
