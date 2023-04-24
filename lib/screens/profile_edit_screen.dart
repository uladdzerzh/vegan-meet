//this is the screen where the user can edit their profile


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegan_meet/models/user_model.dart';
import 'package:vegan_meet/services/database_service.dart';
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

  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
