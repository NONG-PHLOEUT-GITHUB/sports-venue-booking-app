import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/register_controller.dart';
import 'package:frontend/core/services/firebase_service.dart';
import 'package:frontend/data/datasources/firebase_booking_datasource.dart';
import 'package:frontend/data/datasources/firebase_venue_datasource.dart';
import 'package:frontend/data/repositories/booking_repository_impl.dart';
import 'package:frontend/data/repositories/venue_repository_impl.dart';
import 'package:frontend/domain/repositories/booking_repository.dart';
import 'package:frontend/domain/repositories/venue_repository.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/presentation/controllers/booking_controller.dart';
import 'package:frontend/presentation/controllers/venue_controller.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'screens/layout.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/controllers/locale_controller.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/core/theme/theme.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController(), permanent: true);
  Get.put(RegisterController());
  Get.put(LocaleController());

  await GetStorage.init(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   // Insert venues on app start
  // await insertVenues();
  
  // 1️⃣ Bind services
  Get.put(FirebaseService());

   // Bind datasources
  Get.put(FirebaseVenueDataSource(Get.find<FirebaseService>()));
  Get.put(FirebaseBookingDataSource(Get.find<FirebaseService>()));

  // Bind repositories
  Get.put<VenueRepository>(
      VenueRepositoryImpl(Get.find<FirebaseVenueDataSource>()));
  Get.put<BookingRepository>(
      BookingRepositoryImpl(Get.find<FirebaseBookingDataSource>()));

  // Bind controllers
  Get.put(VenueController(Get.find<VenueRepository>()));
  Get.put(BookingController(Get.find<BookingRepository>()));
  runApp(const MyApp());
}

Future<void> insertVenues() async {
  final firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> rawData = [
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343.jpg&fm=jpg',
      "title": "Water football field",
      "location": "Phnom Penh",
      "time": "07:00 AM - 11:00 PM",
      "price": 20.00,
      "slots": "2 Field Available",
    },
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
      "title": "Beach volleyball field",
      "location": "Phnom Penh",
      "time": "08:00 AM - 10:00 PM",
      "price": 20.00,
      "slots": "2 Field Available",
    },
    {
      "imageUrl":
          'https://5.imimg.com/data5/SELLER/Default/2023/8/335122442/GI/HG/ER/19508713/synthetic-basketball-court.jpeg',
      "title": "Basketball Court A",
      "location": "Phnom Penh",
      "time": "08:00 AM - 10:00 PM",
      "price": 25.00,
      "slots": "1 Court Available",
    },
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
      "title": "Indoor Futsal Pitch",
      "location": "Phnom Penh",
      "time": "09:00 AM - 12:00 PM",
      "price": 30.00,
      "slots": "3 Pitches Available",
    },
    {
      "imageUrl":
          'https://images.stockcake.com/public/2/e/5/2e5770ce-1bde-4303-97b9-5933496291ca_large/sunset-soccer-scene-stockcake.jpg',
      "title": "Sunset Soccer Field",
      "location": "Phnom Penh",
      "time": "04:00 PM - 07:00 PM",
      "price": 22.00,
      "slots": "1 Field Available",
    },
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
      "title": "Morning Grass Pitch",
      "location": "Phnom Penh",
      "time": "06:00 AM - 09:00 AM",
      "price": 18.00,
      "slots": "2 Fields Available",
    },
  ];

  for (var venue in rawData) {
    final docId = firestore.collection('venues').doc().id; // auto-generated ID
    await firestore.collection('venues').doc(docId).set(venue);
    print('Inserted venue: ${venue["title"]}');
  }

  print("All venues inserted successfully!");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LocaleController localeController = Get.find();

    return Obx(
      () => GetMaterialApp(
        locale: localeController.locale,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeController.themeMode.value,
        home: MainLayout(),
        // home: const SplashScreen(),
      ),
      // home: const OtpVerificationPage(),
    );
  }
}
