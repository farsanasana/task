import 'package:get/get.dart';
import 'package:task/presentation/auth/signup/signup_binding.dart';
import 'package:task/presentation/auth/signup/signup_view.dart';
import 'package:task/presentation/clients/add_client/add_client_binding.dart';
import 'package:task/presentation/clients/add_client/add_client_view.dart';
import 'package:task/presentation/clients/client_details/client_details_binding.dart';
import 'package:task/presentation/clients/client_details/client_details_view.dart';
import 'package:task/presentation/clients/client_list/client_list_binding.dart';
import 'package:task/presentation/clients/client_list/client_list_view.dart';
import 'package:task/presentation/clients/edit_client/edit_client_binding.dart';
import 'package:task/presentation/clients/edit_client/edit_client_view.dart';
import 'package:task/presentation/dashboard/dashboard_binding.dart';
import '../presentation/auth/login/login_view.dart';
import '../presentation/auth/login/login_binding.dart';
import '../presentation/dashboard/dashboard_view.dart';
import '../presentation/splash/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
    name: AppRoutes.signup,
    page: () => const SignupView(),
    binding: SignupBinding(),
  ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
     GetPage(
      name: AppRoutes.clients,
      page: () => const ClientListView(),
      binding: ClientListBinding(),
    ),
    GetPage(
      name: AppRoutes.addClient,
      page: () => const AddClientView(),
      binding: AddClientBinding(),
    ),
    GetPage(
  name: AppRoutes.editClient,
  page: () => const EditClientView(),
  binding: EditClientBinding(),
),
GetPage(
  name: AppRoutes.clientDetails,
  page: () => const ClientDetailsView(),
  binding: ClientDetailsBinding(),
),

  ];
}
