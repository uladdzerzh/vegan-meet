// this file contains the code for the register screen

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegan_meet/models/user_model.dart';
import 'package:vegan_meet/screens/home_screen.dart';
import 'package:vegan_meet/services/auth_service.dart';
import 'package:vegan_meet/services/database_service.dart';
import 'package:vegan_meet/services/image_picker_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  DietType? _selectedDietType;
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final databaseService = Provider.of<DatabaseService>(context);
    final imagePickerService = Provider.of<ImagePickerService>(context);
    final storageService = Provider.of<DatabaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pickedImage != null
                ? Image.file(
                    _pickedImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                  ),
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () async {
                File? pickedImage = await imagePickerService.pickImage();
                setState(() {
                  _pickedImage = pickedImage;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
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
                String? uid = await authService.registerWithEmailAndPassword(
                  _emailController.text,
                  _passwordController.text,
                );

                if (uid != null) {
                  String imageUrl = '';
                  if (_pickedImage != null) {
                    imageUrl = await databaseService.uploadProfileImage(
                        uid, _pickedImage!);
                  }

                  UserModel newUser = UserModel(
                    uid: uid,
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    city: _cityController.text,
                    dietType: _selectedDietType!,
                    imageUrl: imageUrl,
                  );

                  await databaseService.updateUser(newUser);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registration failed')),
                  );
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
