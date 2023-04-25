import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegan_meet/models/user_model.dart';
import 'package:vegan_meet/services/database_service.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Users'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: databaseService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${user.firstName} ${user.lastName}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('City: ${user.city}'),
                        Text('Diet Type: ${user.dietType.toString().split('.').last}'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
