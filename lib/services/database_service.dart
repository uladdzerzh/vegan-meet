import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vegan_meet/models/user_model.dart';

class DatabaseService {
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users');

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Get user information by uid
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot userDoc = await _userCollection.doc(uid).get();
      if (userDoc.exists) {
        return UserModel.fromDocumentSnapshot(userDoc);
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Update user information
  Future<void> updateUser(UserModel user) async {
    await _userCollection.doc(user.uid).set(user.toJson());
  }

  // Stream to get users as a QuerySnapshot
  Stream<QuerySnapshot> getUsersStream() {
    return _userCollection.snapshots();
  }

  // Stream to get users as a List<UserModel>
  Stream<List<UserModel>> getUsers() {
    return _userCollection.snapshots().map((QuerySnapshot querySnapshot) =>
        querySnapshot.docs
            .map((doc) => UserModel.fromDocumentSnapshot(doc))
            .toList());
  }

  // Upload profile image to Firebase Storage
  Future<String> uploadProfileImage(String uid, File image) async {
    try {
      final ref = _firebaseStorage.ref().child('profile_images').child('$uid.jpg');
      await ref.putFile(image);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  // Get profile image URL from Firebase Storage
  Future<String> getProfileImageUrl(String uid) async {
    try {
      final ref = _firebaseStorage.ref().child('profile_images').child('$uid.jpg');
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }
}
