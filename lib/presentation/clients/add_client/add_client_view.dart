import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            /// Client Name (Required)
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                labelText: 'Client Name *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            /// Phone Number (Required)
            TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: 'Phone Number *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            /// Company Name
            TextField(
              controller: controller.companyController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            /// Type of Business (Dropdown – Mandatory)
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.businessType.value.isEmpty
                    ? null
                    : controller.businessType.value,
                items: const [
                  DropdownMenuItem(value: 'Retail', child: Text('Retail')),
                  DropdownMenuItem(value: 'Service', child: Text('Service')),
                  DropdownMenuItem(
                    value: 'Manufacturing',
                    child: Text('Manufacturing'),
                  ),
                ],
                onChanged: (val) => controller.businessType.value = val!,
                decoration: const InputDecoration(
                  labelText: 'Type of Business *',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// Currently Using System (Yes/No – Mandatory)
            Obx(
              () => SwitchListTile(
                title: const Text('Currently Using System'),
                value: controller.usingSystem.value,
                onChanged: (val) => controller.usingSystem.value = val,
              ),
            ),

            /// Customer Potential (Dropdown)
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
            const SizedBox(height: 16),
            /// Address
TextField(
  controller: controller.addressController,
  maxLines: 2,
  decoration: const InputDecoration(
    labelText: 'Address',
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 12),


            /// GPS Location
            Obx(
              () => ElevatedButton.icon(
                onPressed: controller.isFetchingLocation.value
                    ? null
                    : controller.getLocation,
                icon: const Icon(Icons.location_on),
                label: Text(
                  controller.latitude.value == 0
                      ? 'Get GPS Location'
                      : 'Location Captured',
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// Save Button
            ElevatedButton(
              onPressed: controller.saveClient,
              
              child: const Text('Save Client'),
            ),
          ],
        ),
      ),
    );
  }
}
