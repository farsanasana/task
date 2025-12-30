import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client_list_viewmodel.dart';
import '../../../core/utils/communication_utils.dart';

class ClientListView extends GetView<ClientListViewModel> {
  const ClientListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clients')),
      body: Obx(() {
        if (controller.clients.isEmpty) {
          return const Center(child: Text('No clients'));
        }
        return ListView.builder(
          itemCount: controller.clients.length,
          itemBuilder: (_, index) {
            final client = controller.clients[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(client.name),
                subtitle: Text(client.phone),

                /// 🔹 ACTION BUTTONS
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    /// 📞 CALL
                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.green),
                      onPressed: () {
                        CommunicationUtils.callClient(client.phone);
                      },
                    ),

                    /// 💬 SMS
                    IconButton(
                      icon: const Icon(Icons.message, color: Colors.blue),
                      onPressed: () {
                        CommunicationUtils.smsClient(client.phone);
                      },
                    ),

               
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-client'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
