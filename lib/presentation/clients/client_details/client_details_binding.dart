import 'package:get/get.dart';
import 'client_details_viewmodel.dart';

class ClientDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientDetailsViewModel());
  }
}
