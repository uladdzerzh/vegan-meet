// this file is used to display the user's profile


import 'package:flutter/material.dart';
import 'package:vegan_meet/models/user_model.dart';
import 'package:vegan_meet/screens/profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    String imageUrl = user.imageUrl.isNotEmpty && user.imageUrl.startsWith('http')
        ? user.imageUrl
        : 'https://via.placeholder.com/150';

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
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
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
