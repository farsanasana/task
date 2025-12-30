import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/client_model.dart';

class ClientDetailsViewModel extends GetxController {
  late ClientModel client;

  final noteController = TextEditingController();
  final remarksController = TextEditingController();
  final followUpDate = Rxn<DateTime>();

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    client = Get.arguments as ClientModel;
  }

  /// 📅 Pick Follow-up Date
  Future<void> pickFollowUpDate() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      followUpDate.value = date;
    }
  }

  /// 💾 Save Notes
  Future<void> saveNotes() async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('clients')
        .doc(client.id)
        .update({
      'notes': noteController.text.trim(),
      'remarks': remarksController.text.trim(),
      'followUpDate': followUpDate.value != null
          ? Timestamp.fromDate(followUpDate.value!)
          : null,
    });

    Get.snackbar('Saved', 'Client notes updated');
  }

  @override
  void onClose() {
    noteController.dispose();
    remarksController.dispose();
    super.onClose();
  }
}
