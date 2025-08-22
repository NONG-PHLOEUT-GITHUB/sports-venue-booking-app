import '../../core/services/firebase_service.dart';

class FirebaseUserDataSource {
  final FirebaseService firebaseService;

  FirebaseUserDataSource(this.firebaseService);

  Future<Map<String, dynamic>?> getUser(String id) {
    return firebaseService.getDocument("users", id);
  }

  Future<void> createUser(String id, Map<String, dynamic> data) {
    return firebaseService.setDocument("users", id, data);
  }
}
