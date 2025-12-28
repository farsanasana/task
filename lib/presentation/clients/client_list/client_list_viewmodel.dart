import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/data sources/remote/client_firebase_datasource.dart';
import '../../../data/models/client_model.dart';

class ClientListViewModel extends GetxController {
  final clients = <ClientModel>[].obs;
  final _datasource = ClientFirebaseDatasource();

  @override
  void onInit() {
    super.onInit();
    fetchClients();
  }

  void fetchClients() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    _datasource.getClients(userId).listen((data) {
      clients.value = data;
    });
  }
}
