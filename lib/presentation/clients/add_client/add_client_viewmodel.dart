import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/services/location_service.dart';

class AddClientViewModel extends GetxController {
  final locationService = LocationService();

  /// Observable latitude & longitude
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  final isFetchingLocation = false.obs;

  /// 📍 GET CURRENT LOCATION
  Future<void> getLocation() async {
    try {
      isFetchingLocation.value = true;

      final Position position =
          await locationService.getCurrentLocation();

      latitude.value = position.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      Get.snackbar(
        'Location Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isFetchingLocation.value = false;
    }
  }
}
