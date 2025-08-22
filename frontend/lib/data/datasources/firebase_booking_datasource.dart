import '../../core/services/firebase_service.dart';

class FirebaseBookingDataSource {
  final FirebaseService firebaseService;

  FirebaseBookingDataSource(this.firebaseService);

  Future<void> createBooking(String id, Map<String, dynamic> data) {
    return firebaseService.setDocument("bookings", id, data);
  }

  Future<Map<String, dynamic>?> getBooking(String id) {
    return firebaseService.getDocument("bookings", id);
  }

  Future<List<Map<String, dynamic>>> getAllBookings() {
    return firebaseService.getCollection("bookings");
  }
}
