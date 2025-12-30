import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SignupViewModel extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final isLoading = false.obs;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> signUp() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;

      // 🔐 Create user
      final cred = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = cred.user!.uid;

      // 💾 Save user in Firestore
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      Get.snackbar('Success', 'Account created successfully');
      Get.offAllNamed(AppRoutes.login);

    } on FirebaseAuthException catch (e) {
      Get.snackbar('Signup Failed', e.message ?? 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  bool _validate() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Name is required');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Enter a valid email');
      return false;
    }
    if (passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
