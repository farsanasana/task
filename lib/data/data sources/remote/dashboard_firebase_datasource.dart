import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/models/client_model.dart';

class DashboardFirebaseDatasource {
  CollectionReference<Map<String, dynamic>> _clientRef(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('clients');
  }

  /// 🔢 Total clients count
  Stream<int> totalClients(String uid) {
    return _clientRef(uid) 
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// 🕒 Recent clients (last 3)
  Stream<List<ClientModel>> recentClients(String uid) {
    return _clientRef(uid)
        .orderBy('createdAt', descending: true)
        .limit(3)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ClientModel.fromFirestore(doc))
              .toList(),
        );
  }
}
