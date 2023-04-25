import 'package:cloud_firestore/cloud_firestore.dart';

enum DietType {
  vegan,
  vegetarian,
  ovoVegetarian,
  lactoOvoVegetarian,
}

class UserModel {
  String uid;
  String firstName;
  String lastName;
  String city;
  DietType dietType;
  String imageUrl;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.dietType,
    required this.imageUrl,
  });

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    DietType dietType = DietType.values.firstWhere(
            (e) => e.toString().split('.').last == data['dietType'],
        orElse: () => DietType.vegan);

    return UserModel(
      uid: data['uid'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      city: data['city'],
      dietType: dietType,
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  // converting UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'city': city,
      'dietType': dietType.toString().split('.').last,
      'imageUrl': imageUrl,
    };
  }
}
