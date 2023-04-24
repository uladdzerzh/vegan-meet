// In this file we will create the home screen of our app
// Data is fetched from the database and displayed on the screen


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegan_meet/screens/user_list_screen.dart';
import 'package:vegan_meet/services/auth_service.dart';
import 'package:vegan_meet/services/database_service.dart';
import 'package:vegan_meet/screens/profile_screen.dart';
import 'package:vegan_meet/models/user_model.dart';
import 'package:vegan_meet/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final databaseService = Provider.of<DatabaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vegan Meet'),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Text('Welcome to Vegan Meet!'),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>UserListScreen()),
                );
                },
            child: const Text('Users'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String uid = authService.currentUser!.uid;
          UserModel? user = await databaseService.getUser(uid);
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
            );
          }
        },
        child: const Icon(Icons.person),
      ),
    );
  }
}
