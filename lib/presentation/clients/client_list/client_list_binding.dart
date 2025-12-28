import 'package:get/get.dart';
import 'package:task/presentation/clients/client_list/client_list_viewmodel.dart';

class ClientListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientListViewModel>(() => ClientListViewModel());
  }
}