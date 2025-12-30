import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_client_viewmodel.dart';

class EditClientView extends GetView<EditClientViewModel> {
  const EditClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Client')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Client Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: controller.companyController,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.businessType.value.isEmpty
                      ? null
                      : controller.businessType.value,
                  items: const [
                    DropdownMenuItem(value: 'Retail', child: Text('Retail')),
                    DropdownMenuItem(value: 'Service', child: Text('Service')),
                    DropdownMenuItem(value: 'Manufacturing', child: Text('Manufacturing')),
                  ],
                  onChanged: (val) => controller.businessType.value = val!,
                  decoration: const InputDecoration(
                    labelText: 'Business Type',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Obx(
                () => SwitchListTile(
                  title: const Text('Currently Using System'),
                  value: controller.usingSystem.value,
                  onChanged: (val) => controller.usingSystem.value = val,
                ),
              ),

              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.customerPotential.value.isEmpty
                      ? null
                      : controller.customerPotential.value,
                  items: const [
                    DropdownMenuItem(value: 'Low', child: Text('Low')),
                    DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                    DropdownMenuItem(value: 'High', child: Text('High')),
                  ],
                  onChanged: (val) => controller.customerPotential.value = val!,
                  decoration: const InputDecoration(
                    labelText: 'Customer Potential',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: controller.updateClient,
                child: const Text('Update Client'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
