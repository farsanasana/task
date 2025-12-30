import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/data sources/local/hive_auth_datasource.dart';
import '../../data/data sources/remote/dashboard_firebase_datasource.dart';
import '../../data/models/client_model.dart';
import '../../routes/app_routes.dart';


class DashboardViewModel extends GetxController {
  final totalClients = 0.obs;
  final recentClients = <ClientModel>[].obs;
  final isLoading = true.obs;

  final _datasource = DashboardFirebaseDatasource();

  @override
  void onInit() {
    super.onInit();
    _loadDashboard();
  }


late StreamSubscription _countSub;
late StreamSubscription _recentSub;

void _loadDashboard() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  _countSub = _datasource.totalClients(user.uid).listen((count) {
    totalClients.value = count;
  });

  _recentSub = _datasource.recentClients(user.uid).listen((clients) {
    recentClients.value = clients;
    isLoading.value = false;
  });
}

Future<void> deleteClient(String clientId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('clients')
      .doc(clientId)
      .delete();

  Get.snackbar('Deleted', 'Client removed successfully');
}

@override
void onClose() {
  _countSub.cancel();
  _recentSub.cancel();
  super.onClose();
}

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await HiveAuthDataSource().clearUser();
    Get.offAllNamed(AppRoutes.login);
  }
}
