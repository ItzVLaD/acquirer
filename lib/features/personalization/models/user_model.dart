import 'package:cloud_firestore/cloud_firestore.dart';

/// Class with model of user data
class UserModel {
  /// Variables
  final String id;
  String username;
  final String email;
  final String profilePicture;
  final bool isAdmin;
  final List<String> favorites;
  final Map<String, int> cart;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.profilePicture,
    required this.isAdmin,
    required this.cart,
    required this.favorites,
  });

  /// Method to return an empty value
  static UserModel empty() => UserModel(email: '', id: '', profilePicture: '', username: '', cart: {}, favorites: [], isAdmin: false);

  /// Method to convert to Json
  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Email': email,
      'ProfilePicture': profilePicture,
      'IsAdmin': isAdmin,
      'Cart': cart,
      'Favorites': favorites,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        email: data['Email'] ?? '',
        id: document.id,
        profilePicture: data['ProfilePicture'] ?? '',
        username: data['Username'] ?? '',
        cart: data['Cart'] != null ? Map<String, int>.from(data['Cart']) : {},
        favorites: data['Favorites'] != null ? Set<String>.from(data['Favorites']).toList() : [],
        isAdmin: data['IsAdmin'] ?? false,
      );
    } else {
      return UserModel.empty();
    }
  }
}
