import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditClientViewModel extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();

  final businessType = ''.obs;
  final usingSystem = false.obs;
  final customerPotential = ''.obs;

  final isLoading = true.obs;

  late final String clientId;
  late final String uid;

  @override
  void onInit() {
    super.onInit();
    clientId = Get.arguments as String;
    uid = FirebaseAuth.instance.currentUser!.uid;
    _loadClient();
  }

  /// 🔄 Load existing client data
  Future<void> _loadClient() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('clients')
        .doc(clientId)
        .get();

    final data = doc.data();
    if (data == null) return;

    nameController.text = data['name'] ?? '';
    phoneController.text = data['phone'] ?? '';
    companyController.text = data['company'] ?? '';
    businessType.value = data['businessType'] ?? '';
    usingSystem.value = data['usingSystem'] ?? false;
    customerPotential.value = data['customerPotential'] ?? '';

    isLoading.value = false;
  }

  /// 💾 Update client
  Future<void> updateClient() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('clients')
        .doc(clientId)
        .update({
      'name': nameController.text.trim(),
      'phone': phoneController.text.trim(),
      'company': companyController.text.trim(),
      'businessType': businessType.value,
      'usingSystem': usingSystem.value,
      'customerPotential': customerPotential.value,
      'updatedAt': Timestamp.now(),
    });

    Get.back();
    Get.snackbar('Updated', 'Client updated successfully');
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    companyController.dispose();
    super.onClose();
  }
}
