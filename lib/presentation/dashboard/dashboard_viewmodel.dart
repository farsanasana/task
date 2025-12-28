import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/data sources/local/hive_auth_datasource.dart';
import '../../routes/app_routes.dart';

class DashboardViewModel extends GetxController {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await HiveAuthDataSource().clearUser();
    Get.offAllNamed(AppRoutes.login);
  }
}
