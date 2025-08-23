import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/booking_repository.dart';

class BookingController extends GetxController {
  final BookingRepository repository;

  BookingController(this.repository);

  final bookings = <Booking>[].obs;
  final tickets = <TicketData>[].obs;
  final isLoading = false.obs;

  // Form fields
  final fullName = ''.obs;
  final phoneNumber = ''.obs;
  final selectedField = 'Field C'.obs;
  final bookingDate = ''.obs;
  final bookingTime = ''.obs;
  final totalPrice = 0.0.obs;

  bool get isValid =>
      fullName.isNotEmpty && phoneNumber.isNotEmpty && selectedField.isNotEmpty;

  /// Fetch all bookings and corresponding venue info
  Future<void> fetchBookings() async {
    isLoading.value = true;

    final data = await repository.getAllBookings();
    bookings.value = data;

    tickets.clear();
    for (var b in data) {
      try {
        final venue = await repository.getVenueById(b.venueId);
        tickets.add(TicketData(booking: b, venue: venue));
      } catch (e) {
        print('Error fetching venue for booking ${b.id}: $e');
      }
    }

    isLoading.value = false;
  }

  /// Create a new booking and add it to tickets
  Future<void> createBooking(String venueId) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? "guest"; 
    
    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      venueId: venueId,
      field: selectedField.value,
      userId: userId,
      userFullName: fullName.value,
      phoneNumber: phoneNumber.value,
      date: bookingDate.value,
      time: bookingTime.value,
      price: totalPrice.value.toStringAsFixed(2),
    );

    await repository.addBooking(booking);
    bookings.add(booking);

    try {
      final venue = await repository.getVenueById(venueId);
      tickets.add(TicketData(booking: booking, venue: venue));
    } catch (e) {
      print('Error fetching venue for new booking ${booking.id}: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }
}
