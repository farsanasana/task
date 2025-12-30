import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/routes/app_routes.dart';
import 'client_list_viewmodel.dart';
import '../../../core/utils/communication_utils.dart';

class ClientListView extends GetView<ClientListViewModel> {
  const ClientListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(title: const Text('Clients')),
  body: Column(
    children: [
      // 🔍 SEARCH BAR
      Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          onChanged: (value) {
            controller.searchQuery.value = value;
          },
          decoration: InputDecoration(
            hintText: 'Search by name or phone',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      // 📋 CLIENT LIST
      Expanded(
        child: Obx(() {
          if (controller.filteredClients.isEmpty) {
            return const Center(child: Text('No clients found'));
          }

          return ListView.builder(
            itemCount: controller.filteredClients.length,
            itemBuilder: (_, index) {
              final client = controller.filteredClients[index];

              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.clientDetails,
                      arguments: client,
                    );
                  },
                  title: Text(client.name),
                  subtitle: Text(client.phone),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.call, color: Colors.green),
                        onPressed: () =>
                            CommunicationUtils.callClient(client.phone),
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.message, color: Colors.blue),
                        onPressed: () =>
                            CommunicationUtils.smsClient(client.phone),
                      ),
                      
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    ],
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () => Get.toNamed('/add-client'),
    child: const Icon(Icons.add),
  ),
);

  }
}
