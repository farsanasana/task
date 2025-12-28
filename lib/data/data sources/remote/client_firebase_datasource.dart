import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/models/client_model.dart';


class ClientFirebaseDatasource {
  final _collection = FirebaseFirestore.instance.collection('clients');

  Future<void> addClient(ClientModel client) async {
    await _collection.add(client.toJson());
  }

  Stream<List<ClientModel>> getClients(String userId) {
    return _collection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ClientModel.fromJson(doc.id, doc.data()))
            .toList());
  }

  Future<void> updateClient(ClientModel client) async {
    await _collection.doc(client.id).update(client.toJson());
  }
}
