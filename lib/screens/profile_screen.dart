// this file is used to display the user's profile


import 'package:flutter/material.dart';
import 'package:vegan_meet/models/user_model.dart';
import 'package:vegan_meet/screens/profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEditScreen(user: user)),
              );
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: ${user.firstName}'),
            SizedBox(height: 8),
            Text('Last Name: ${user.lastName}'),
            SizedBox(height: 8),
            Text('City: ${user.city}'),
            SizedBox(height: 8),
            Text('Diet Type: ${user.dietType.toString().split('.').last}'),
          ],
        ),
      ),
    );
  }
}
