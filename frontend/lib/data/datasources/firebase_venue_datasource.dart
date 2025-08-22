import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/services/firebase_service.dart';

class FirebaseVenueDataSource {
  final FirebaseService firebaseService;

  FirebaseVenueDataSource(this.firebaseService);

  CollectionReference get _venuesRef =>
      firebaseService.firestore.collection('venues');

  Future<List<Map<String, dynamic>>> getAllVenues() async {
    final snapshot = await _venuesRef.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<void> addVenue(Map<String, dynamic> venueData, String id) async {
    await _venuesRef.doc(id).set(venueData);
  }
}
