import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/Routes.dart';
import 'package:my_app/screens/BookTable.dart';
import 'package:my_app/screens/CustomerBookings.dart';
import 'package:my_app/screens/FiltersScreen.dart';
import 'package:my_app/screens/Homepage.dart';
import 'package:my_app/screens/MapScreen.dart';
import 'package:my_app/screens/RestaurantDetailsScreen.dart';
import 'package:my_app/screens/SignIn.dart';
import 'package:my_app/Screens/Splash.dart';
import 'package:my_app/screens/Signup.dart';
import 'package:my_app/screens/manager/ManagerBookingEdit.dart';
import 'package:my_app/screens/manager/ManagerHomepage.dart';
import 'package:dcdg/dcdg.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = PostHttpOverrides();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(const MyApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace,fatal: true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurants',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF414BB2),
          secondary: const Color(0xFF414BB2),
        ),
      ),
      initialRoute: Routes.welcomeScreen,
      routes: {
        Routes.welcomeScreen: (ctx) => const Splash(),
        Routes.signIn: (ctx) => const SignIn(),
        Routes.signUp: (ctx) => const Signup(),
        Routes.homepage: (ctx) => const Homepage(),
        Routes.restaurantDetailsScreen: (ctx) => const RestaurantDetailsScreen(),
        Routes.bookTable: (ctx) => const BookTable(),
        Routes.mapScreen: (ctx) => const MapScreen(),
        Routes.managerHomepage: (ctx) => const ManagerHomepage(),
        Routes.customerBooking: (ctx) => const CustomerBookings(),
        Routes.managerBookingEdit: (ctx) => const ManagerBookingEdit(),
        Routes.filtersScreen: (ctx) => const FiltersScreen(),
      },
    );
  }
}