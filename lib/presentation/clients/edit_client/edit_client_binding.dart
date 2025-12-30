import 'package:get/get.dart';
import 'edit_client_viewmodel.dart';

class EditClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditClientViewModel());
  }
}
