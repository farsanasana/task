import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task/data/data%20sources/remote/client_firebase_datasource.dart';
import 'package:task/data/models/client_model.dart';

class ClientListViewModel extends GetxController {
  final clients = <ClientModel>[].obs;
  final filteredClients = <ClientModel>[].obs;
  final searchQuery = ''.obs;
  final isLoading = true.obs;

  final _datasource = ClientFirebaseDatasource();

  @override
  void onInit() {
    super.onInit();
    fetchClients();

    // 🔍 react to search changes
    ever(searchQuery, (_) => _applySearch());
  }

  void fetchClients() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _datasource.getClients(user.uid).listen((data) {
      clients.value = data;
      isLoading.value = false;

      // ✅ ALWAYS refresh filtered list
      _applySearch();
    });
  }

  void _applySearch() {
    final query = searchQuery.value.trim().toLowerCase();

    if (query.isEmpty) {
      filteredClients.value = clients;
    } else {
      filteredClients.value = clients.where((client) {
        return client.name.toLowerCase().contains(query) ||
            client.phone.contains(query);
      }).toList();
    }
  }
}
