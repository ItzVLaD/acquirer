import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/personalization/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

/// Class with repository of user data
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Method to save user record
  Future<void> saveUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).set(user.toJson());
  }

  /// Function to fetch user data
  Future<UserModel> fetchUserDetails() async {
    final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();

    if (documentSnapshot.exists) {
      return UserModel.fromSnapshot(documentSnapshot);
    } else {
      return UserModel.empty();
    }
  }

  /// Function to update user data
  Future<void> updateUserDetails(UserModel updatedUser) async {
    await _db.collection('Users').doc(updatedUser.id).update(updatedUser.toJson());
  }

  /// Function to update any single field
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).update(json);
  }

  /// Function to delete user record from Firestore
  Future<void> deleteUserRecord(String userId) async {
    await _db.collection('Users').doc(userId).delete();
  }
}
