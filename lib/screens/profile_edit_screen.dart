//this is the screen where the user can edit their profile


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegan_meet/models/user_model.dart';
import 'package:vegan_meet/services/database_service.dart';
import 'package:vegan_meet/services/image_picker_service.dart';
import 'package:vegan_meet/screens/home_screen.dart';

class ProfileEditScreen extends StatefulWidget {
  final UserModel user;

  ProfileEditScreen({required this.user});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  DietType? _selectedDietType;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _cityController.text = widget.user.city;
    _selectedDietType = widget.user.dietType;
  }

  Future<void> _updateProfileImage(BuildContext context) async {
    final imagePickerService = Provider.of<ImagePickerService>(
        context, listen: false);
    final databaseService = Provider.of<DatabaseService>(
        context, listen: false);

    File? newImage = await imagePickerService.pickImage();
    if (newImage != null) {
      String imageUrl = await databaseService.uploadProfileImage(
          widget.user.uid, newImage);
      if (imageUrl.isNotEmpty) {
        setState(() {
          widget.user.imageUrl = imageUrl;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context);

    String imageUrl = widget.user.imageUrl.isNotEmpty &&
        widget.user.imageUrl.startsWith('http')
        ? widget.user.imageUrl
        : 'https://via.placeholder.com/150';

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
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
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        _updateProfileImage(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(height: 16),
            DropdownButton<DietType>(
              value: _selectedDietType,
              onChanged: (DietType? newValue) {
                setState(() {
                  _selectedDietType = newValue!;
                });
              },
              items: DietType.values.map((DietType dietType) {
                return DropdownMenuItem<DietType>(
                  value: dietType,
                  child: Text(dietType.toString().split('.').last),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                widget.user.firstName = _firstNameController.text;
                widget.user.lastName = _lastNameController.text;
                widget.user.city = _cityController.text;
                widget.user.dietType = _selectedDietType!;

                await databaseService.updateUser(widget.user);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

