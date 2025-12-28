import 'package:get/get.dart';
import 'dashboard_viewmodel.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardViewModel>(() => DashboardViewModel());
  }
}
