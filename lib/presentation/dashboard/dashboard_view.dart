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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 👋 Welcome
            Text(
              'Welcome 👋',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            /// 📊 STATS CARDS
            Row(
              children: [
                _statCard(
                  title: 'Clients',
                  value: '24',
                  icon: Icons.people,
                  color: Colors.blue,
                ),
                const SizedBox(width: 12),
                _statCard(
                  title: 'Follow Ups',
                  value: '5',
                  icon: Icons.alarm,
                  color: Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ⚡ QUICK ACTIONS
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
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

            const SizedBox(height: 24),

            /// 📋 RECENT ACTIVITY
            Text(
              'Recent Clients',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            _recentTile('John Doe', 'Called • Today'),
            _recentTile('Acme Corp', 'Meeting • Yesterday'),
            _recentTile('Sarah Smith', 'SMS • 2 days ago'),
          ],
        ),
      ),
    );
  }

  /// 📊 STAT CARD
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
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  /// ⚡ ACTION CARD
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

  /// 📋 RECENT ITEM
  Widget _recentTile(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
