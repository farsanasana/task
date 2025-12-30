import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/data sources/local/hive_auth_datasource.dart';
import '../../../data/models/user_model.dart';


class LoginViewModel extends GetxController {
  /// Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// State
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  /// Login function
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_validate(email, password)) return;

    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
final user = _auth.currentUser;

if (user != null) {
  final hive = HiveAuthDataSource();
  await hive.saveUser(
    UserModel(
      uid: user.uid,
      email: user.email ?? '',
    ),
  );
}
      /// Navigate to dashboard after success
      Get.offAllNamed('/dashboard');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login Failed',
        e.message ?? 'Authentication error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Input validation
  bool _validate(String email, String password) {
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (password.isEmpty || password.length < 6) {
      Get.snackbar(
        'Invalid Password',
        'Password must be at least 6 characters',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

 
}
