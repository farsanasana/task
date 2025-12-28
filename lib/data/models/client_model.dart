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
  });

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
      };

  factory ClientModel.fromJson(String id, Map<String, dynamic> json) {
    return ClientModel(
      id: id,
      userId: json['userId'],
      name: json['name'],
      phone: json['phone'],
      company: json['company'],
      businessType: json['businessType'],
      usingSystem: json['usingSystem'],
      potential: json['potential'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }
}
