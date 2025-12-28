import 'package:get/get.dart';
import 'package:task/presentation/clients/add_client/add_client_viewmodel.dart';

class AddClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddClientViewModel>(() => AddClientViewModel());
  }
}