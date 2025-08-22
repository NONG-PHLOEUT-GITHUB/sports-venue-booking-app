import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> setDocument(String collection, String id, Map<String, dynamic> data) async {
    await firestore.collection(collection).doc(id).set(data);
  }

  Future<Map<String, dynamic>?> getDocument(String collection, String id) async {
    final doc = await firestore.collection(collection).doc(id).get();
    return doc.data();
  }

  Future<List<Map<String, dynamic>>> getCollection(String collection) async {
    final snapshot = await firestore.collection(collection).get();
    return snapshot.docs.map((doc) => {"id": doc.id, ...doc.data()}).toList();
  }

  Future<void> deleteDocument(String collection, String id) async {
    await firestore.collection(collection).doc(id).delete();
  }
}
