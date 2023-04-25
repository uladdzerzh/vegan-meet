import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegan_meet/services/auth_service.dart';
import 'package:vegan_meet/services/database_service.dart';
import 'package:vegan_meet/screens/login_screen.dart';
import 'package:vegan_meet/screens/register_screen.dart';
import 'package:vegan_meet/services/image_picker_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
        Provider<ImagePickerService>(
          create: (context) => ImagePickerService(),
        ),
      ],
      child: MaterialApp(
        title: 'Vegan Meet',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
