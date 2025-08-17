import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_km.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('km'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sports Venue Booking App'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @btnSave.
  ///
  /// In en, this message translates to:
  /// **'Save Change'**
  String get btnSave;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @btnBookNow.
  ///
  /// In en, this message translates to:
  /// **'Booking Now'**
  String get btnBookNow;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Account'**
  String get loginTitle;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, welcome back to account!'**
  String get welcomeMessage;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signInWith.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google or Facebook'**
  String get signInWith;

  /// Button or text for logging out
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// User profile section
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// User profile section
  ///
  /// In en, this message translates to:
  /// **'Book Your Ground'**
  String get bookYourGround;

  /// User profile section
  ///
  /// In en, this message translates to:
  /// **'Great Offers'**
  String get greatOffers;

  /// Button or text for editing user profile
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// List of favorite venues
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Search button or input label
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Placeholder text for search input
  ///
  /// In en, this message translates to:
  /// **'Search by location, sport type, or date'**
  String get searchPlaceholder;

  /// Page or section for venue details
  ///
  /// In en, this message translates to:
  /// **'Venue Details'**
  String get venueDetails;

  /// Label for venue availability
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// Section or list of amenities
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get amenities;

  /// Label for pricing information
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// User reviews section
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// Button to add venue to favorites
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get addToFavorites;

  /// Section or page for booking venues
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// Label for selecting a venue
  ///
  /// In en, this message translates to:
  /// **'Select Venue'**
  String get selectVenue;

  /// Label for selecting date and time
  ///
  /// In en, this message translates to:
  /// **'Select Date & Time'**
  String get selectDateTime;

  /// Button to confirm a booking
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// Message displayed after successful booking
  ///
  /// In en, this message translates to:
  /// **'Booking Successful!'**
  String get bookingSuccess;

  /// Section or label for payment
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// Button to proceed with payment
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// Message displayed after successful payment
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get paymentSuccess;

  /// Message displayed when payment fails
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailure;

  /// Section or link to refund policy details
  ///
  /// In en, this message translates to:
  /// **'ការជូនដំណឹង'**
  String get notifications;

  /// Section or link to refund policy details
  ///
  /// In en, this message translates to:
  /// **'គ្មានការជូនដំណឹងថ្មី'**
  String get noNotifications;

  /// Label for English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Label for Khmer language
  ///
  /// In en, this message translates to:
  /// **'Khmer'**
  String get khmer;

  /// Option to change app language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get changeLanguage;

  /// Option to change app language
  ///
  /// In en, this message translates to:
  /// **'Language Changed'**
  String get languageChanged;

  /// Option to change app language
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// Section title for user's contact information
  ///
  /// In en, this message translates to:
  /// **'Your Contact Info'**
  String get yourContactInfo;

  /// Label for full name field
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Placeholder text for full name field
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// Label for phone number field
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Label for phone number field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Label for phone number field
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterANewPassword;

  /// Label for phone number field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for phone number field
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// Placeholder text for phone number field
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// Section title for booking details
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// Label for field selection dropdown
  ///
  /// In en, this message translates to:
  /// **'Select Field'**
  String get selectField;

  /// Label for selected date
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Label for selected time
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Label for total price
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// Title or label for the notification section or page
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification;

  /// Bottom navigation tab for Home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Bottom navigation tab for Venue selection
  ///
  /// In en, this message translates to:
  /// **'Venue'**
  String get venue;

  /// Bottom navigation tab for viewing or managing tickets
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get ticket;

  /// Bottom navigation tab for user account
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Encouragement or call to action to start the booking process
  ///
  /// In en, this message translates to:
  /// **'Let\'s make a booking'**
  String get makeBooking;

  /// Label for app tutorial or guide
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorial;

  /// Label for language settings
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Title for payment options screen
  ///
  /// In en, this message translates to:
  /// **'Payment Options'**
  String get paymentOptions;

  /// Section title for booking summary
  ///
  /// In en, this message translates to:
  /// **'Summary Information'**
  String get summaryInformation;

  /// Label for location or booking name
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Label for total booking duration
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// Label for selected field(s)
  ///
  /// In en, this message translates to:
  /// **'Field'**
  String get field;

  /// Label for total payment amount
  ///
  /// In en, this message translates to:
  /// **'Total Amount to pay :'**
  String get totalAmountToPay;

  /// Prompt to choose a payment method
  ///
  /// In en, this message translates to:
  /// **'Please select a payment option'**
  String get pleaseSelectPayment;

  /// ABA Pay method label
  ///
  /// In en, this message translates to:
  /// **'ABA Pay'**
  String get abaPay;

  /// Subtitle for ABA Pay method
  ///
  /// In en, this message translates to:
  /// **'Tap to pay with ABA mobile'**
  String get tapToPayWithABA;

  /// Subtitle for ABA Pay method
  ///
  /// In en, this message translates to:
  /// **'Tap to pay with ACLEDA mobile'**
  String get tapToPayWithACLEDA;

  /// Subtitle for KHQR method
  ///
  /// In en, this message translates to:
  /// **'Tap to pay with KHQR mobile'**
  String get tapToPayWithKHQR;

  /// Label for credit or debit card option
  ///
  /// In en, this message translates to:
  /// **'Credit/Debit card'**
  String get creditDebitCard;

  /// Checkout button text
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get checkOut;

  /// KHQR method label
  ///
  /// In en, this message translates to:
  /// **'Transfer Amount'**
  String get transferAmount;

  /// KHQR method label
  ///
  /// In en, this message translates to:
  /// **'Additional Cost'**
  String get addCost;

  /// Title shown after successful payment
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get paymentSuccessful;

  /// Message shown after a successful transaction
  ///
  /// In en, this message translates to:
  /// **'Thank you for payment. Your transaction has been processed successfully'**
  String get paymentThankYou;

  /// Button text to return to the home screen
  ///
  /// In en, this message translates to:
  /// **'Return Home'**
  String get returnHome;

  /// Action to verification code
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// Prompt asking if the user didn't receive the verification code
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code? '**
  String get didNotReceiveCode;

  /// Action to resend the verification code
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// Instruction to enter the OTP verification code sent by email
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code we just sent on your email address or phone number.'**
  String get enterVerificationCode;

  /// Title for the OTP verification screen
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @creditPay.
  ///
  /// In en, this message translates to:
  /// **'Credit Pay'**
  String get creditPay;

  /// No description provided for @cardName.
  ///
  /// In en, this message translates to:
  /// **'Card Name'**
  String get cardName;

  /// No description provided for @cardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get cardHolderName;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @helpsSupports.
  ///
  /// In en, this message translates to:
  /// **'Helps & Supports'**
  String get helpsSupports;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistory;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'km'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'km':
      return AppLocalizationsKm();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
