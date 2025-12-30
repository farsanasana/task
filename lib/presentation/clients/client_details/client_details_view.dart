import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client_details_viewmodel.dart';
import '../../../core/utils/map_utils.dart';

class ClientDetailsView extends GetView<ClientDetailsViewModel> {
  const ClientDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final client = controller.client;

    return Scaffold(
      appBar: AppBar(title: Text(client.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 👤 CLIENT INFO
            _infoTile('Phone', client.phone),
            _infoTile('Company', client.company),
            _infoTile('Business Type', client.businessType),
            _infoTile('Customer Potential', client.potential),

            const SizedBox(height: 20),

            /// 📍 MAP
            Text(
              'Location',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            client.latitude == 0
                ? const Text('No location available')
                : GestureDetector(
                    onTap: () {
                      MapUtils.openMap(
                        client.latitude,
                        client.longitude,
                      );
                    },
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on,
                              size: 40, color: Colors.red),
                          SizedBox(height: 8),
                          Text('Open in Google Maps'),
                        ],
                      ),
                    ),
                  ),

            const SizedBox(height: 24),

            /// 📝 NOTES
            Text(
              'Notes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            TextField(
              controller: controller.noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Add notes about this client',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            /// 📅 FOLLOW-UP DATE
            Obx(
              () => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  controller.followUpDate.value == null
                      ? 'Add Next follow-up date'
                      : 'Follow-up: ${controller.followUpDate.value!.toLocal().toString().split(' ')[0]}',
                ),
                onTap: controller.pickFollowUpDate,
              ),
            ),

            const SizedBox(height: 16),

            /// 🗒️ REMARKS
            Text(
              'Remarks',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            TextField(
              controller: controller.remarksController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Additional remarks',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            /// 💾 SAVE
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.saveNotes,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value.isEmpty ? '-' : value),
          ),
        ],
      ),
    );
  }
}
