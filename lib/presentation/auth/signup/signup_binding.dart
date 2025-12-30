import 'package:get/get.dart';
import 'signup_viewmodel.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupViewModel());
  }
}
