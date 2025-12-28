class ClientEntity {
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

  ClientEntity({
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
  });
}
