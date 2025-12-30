import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  final String id;
  final String userId;
  final String name;
  final String phone;
  final String company;
  final String businessType;
  final bool usingSystem;
  final String potential;
  final double latitude;
  final double longitude;
  final String address;
  final Timestamp createdAt;

  ClientModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.company,
    required this.businessType,
    required this.usingSystem,
    required this.potential,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.createdAt,
  });

  /// 🔁 Firestore → Model
  factory ClientModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ClientModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      company: data['company'] ?? '',
      businessType: data['businessType'] ?? '',
      usingSystem: data['usingSystem'] ?? false,
      potential: data['potential'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      address: data['address'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  /// 🔁 Model → Firestore
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'phone': phone,
        'company': company,
        'businessType': businessType,
        'usingSystem': usingSystem,
        'potential': potential,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'createdAt': createdAt,
      };
}
