import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends GetView<DashboardViewModel> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRM Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome 👋',
                  style: Theme.of(context).textTheme.headlineSmall),

              const SizedBox(height: 20),

              /// 📊 STATS
              Row(
                children: [
                  _statCard(
                    title: 'Clients',
                    value: controller.totalClients.value.toString(),
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// ⚡ ACTIONS
              Text('Quick Actions',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),

              Row(
                children: [
                  _actionCard(
                    icon: Icons.person_add,
                    label: 'Add Client',
                    onTap: () => Get.toNamed('/add-client'),
                  ),
                  const SizedBox(width: 12),
                  _actionCard(
                    icon: Icons.list,
                    label: 'View Clients',
                    onTap: () => Get.toNamed('/clients'),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// 🕒 RECENT CLIENTS
              Text('Recent Clients',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),

            controller.recentClients.isEmpty
    ? const Text('No recent clients')
    : Column(
        children: controller.recentClients.map(
          (client) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(client.name),
              subtitle: Text(client.phone),

              // 👉 EDIT & DELETE BUTTONS
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ✏️ Edit
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Get.toNamed(
                        '/edit-client',
                        arguments: client.id,
                      );
                    },
                  ),

                  /// 🗑️ Delete
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteDialog(context, client.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ).toList(),
      ),

            ],
          ),
        );
      }),
    );
  }
void _showDeleteDialog(BuildContext context, String clientId) {
  Get.defaultDialog(
    title: 'Delete Client',
    middleText: 'Are you sure you want to delete this client?',
    textCancel: 'Cancel',
    textConfirm: 'Delete',
    confirmTextColor: Colors.white,
    onConfirm: () {
      controller.deleteClient(clientId);
      Get.back();
    },
  );
}

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(value,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
