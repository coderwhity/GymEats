import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_eats/firebase_options.dart';
import 'package:gym_eats/notificationServices.dart';
import 'package:gym_eats/providers/basketProvider.dart';
import 'package:gym_eats/providers/categoryProvider.dart';
import 'package:gym_eats/providers/initialDataProvider.dart';
import 'package:gym_eats/providers/recipeProvider.dart';
import 'package:gym_eats/providers/searchProvider.dart';
import 'package:flutter/services.dart';
import 'package:gym_eats/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService _notificationServices = NotificationService();
  _notificationServices.initialize();
  await dotenv.load(fileName: ".env");
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
        SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider<InitialDataProvider>(
          create: (_) => InitialDataProvider(),
        ),
        ChangeNotifierProvider<SelectedCategoryProvider>(
          create: (_) => SelectedCategoryProvider(),
        ),
        ChangeNotifierProvider<BasketProvider>(
          create: (_) => BasketProvider(),
        ),
        ChangeNotifierProvider<RecipeProvider>(
          create: (_) => RecipeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'GymEats',
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 240, 239),
          // Apply Montserrat Alternates font to the whole app
          textTheme: GoogleFonts.montserratAlternatesTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}
