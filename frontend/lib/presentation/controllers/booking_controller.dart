import 'package:get/get.dart';
import '../../domain/entities/booking.dart';
import '../../data/datasources/firebase_booking_datasource.dart';
import '../../core/services/firebase_service.dart';

class BookingController extends GetxController {
  final bookings = <Booking>[].obs;
  final isLoading = false.obs;

  final FirebaseBookingDataSource dataSource = FirebaseBookingDataSource(FirebaseService());

  Future<void> fetchBookings() async {
    isLoading.value = true;
    final dataList = await dataSource.getAllBookings();
    bookings.value = dataList.map((e) => Booking.fromMap(e['id'], e)).toList();
    isLoading.value = false;
  }

  Future<void> addBooking(Booking booking) async {
    await dataSource.createBooking(booking.id, booking.toMap());
    bookings.add(booking);
  }
}
