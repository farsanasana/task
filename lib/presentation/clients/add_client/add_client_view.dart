import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'add_client_viewmodel.dart';

class AddClientView extends GetView<AddClientViewModel> {
  const AddClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Client')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 📍 BUTTON TO FETCH LOCATION
            Obx(() => ElevatedButton.icon(
                  onPressed: controller.isFetchingLocation.value
                      ? null
                      : controller.getLocation,
                  icon: const Icon(Icons.location_on),
                  label: const Text('Get Current Location'),
                )),

            const SizedBox(height: 16),

            /// 🗺️ GOOGLE MAP
            Obx(() {
              if (controller.latitude.value == 0.0 &&
                  controller.longitude.value == 0.0) {
                return const Text('Location not selected');
              }

              return SizedBox(
                height: 250,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      controller.latitude.value,
                      controller.longitude.value,
                    ),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('client'),
                      position: LatLng(
                        controller.latitude.value,
                        controller.longitude.value,
                      ),
                    )
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
