import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/services/location_service.dart';

class AddClientViewModel extends GetxController {
  /// Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();

  /// Dropdown values
  final businessType = ''.obs;
  final usingSystem = false.obs;
  final customerPotential = ''.obs;

  /// Location
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final isFetchingLocation = false.obs;

  final _locationService = LocationService();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /// 📍 Get GPS location
  Future<void> getLocation() async {
    try {
      isFetchingLocation.value = true;
      final Position position =
          await _locationService.getCurrentLocation();

      latitude.value = position.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      Get.snackbar('Location Error', e.toString());
    } finally {
      isFetchingLocation.value = false;
    }
  }

  /// 💾 Save client
Future<void> saveClient() async {


  if (_auth.currentUser == null) {
    Get.snackbar('Auth Error', 'User not logged in');
    return;
  }

  if (!_validate()) return;

  final uid = _auth.currentUser!.uid;

  await _firestore
      .collection('users')
      .doc(uid)
      .collection('clients')
      .add({
    'name': nameController.text.trim(),
    'phone': phoneController.text.trim(),
    'company': companyController.text.trim(),
     'address': addressController.text.trim(),
    'businessType': businessType.value,
    'usingSystem': usingSystem.value,
    'customerPotential': customerPotential.value,
    'latitude': latitude.value,
    'longitude': longitude.value,
    'createdAt': Timestamp.now(),
  });

  Get.back();
  Get.snackbar('Success', 'Client added successfully');
  
  
}

  bool _validate() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Client name is required');
      return false;
    }
    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Phone number is required');
      return false;
    }
    if (businessType.value.isEmpty) {
      Get.snackbar('Error', 'Select type of business');
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    companyController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
