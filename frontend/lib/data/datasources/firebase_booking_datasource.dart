import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/domain/entities/venue.dart';
import '../../core/services/firebase_service.dart';
import '../../domain/entities/booking.dart';

class FirebaseBookingDataSource {
  final FirebaseService firebaseService;

  FirebaseBookingDataSource(this.firebaseService);

  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('bookings');

  Future<List<Map<String, dynamic>>> getAllBookings() async {
    final snapshot = await bookingsCollection.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<void> addBooking(Booking booking) async {
    final docId = booking.id.isNotEmpty ? booking.id : bookingsCollection.doc().id;
    await bookingsCollection.doc(docId).set(booking.toMap());
  }

  Future<Venue> getVenueById(String venueId) async {
    final doc = await firebaseService.firestore.collection('venues').doc(venueId).get();
    if (!doc.exists) {
      throw Exception('Venue not found');
    }
    return Venue.fromMap(doc.id, doc.data()!);
  }
}
