import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/data/repositories/user/user_repository.dart';
import 'package:acquirer/features/personalization/models/user_model.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Class with contrloller for UserModel
class UserController extends GetxController {
  static UserController get instance => Get.find();

  /// Variables
  Rx<UserModel> user = UserModel.empty().obs;
  final _userRepository = Get.put(UserRepository());
  final _authRepository = AuthenticationRepository.instance;
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxBool button = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
    updateCartTotals();
  }

  /// Fetch user records
  Future<void> fetchUserRecord() async {
    final user = await _userRepository.fetchUserDetails();
    this.user(user);
  }

  /// Save user record
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    await fetchUserRecord();

    if (user.value.id.isEmpty) {
      if (userCredential != null) {
        final user = UserModel(
          email: userCredential.user!.email ?? '',
          id: userCredential.user!.uid,
          profilePicture: userCredential.user!.photoURL ?? '',
          username: userCredential.user!.displayName ?? '',
          isAdmin: false,
          cart: {},
          favorites: [],
        );

        await _userRepository.saveUserRecord(user);
      }
    }
    if (button.value) html.window.location.reload();
  }

  Future<void> updateUserFavorites() async {
    Map<String, List<String>> json = {'Favorites': user.value.favorites};
    _userRepository.updateSingleField(json);
  }

  Future<void> updateUserCart() async {
    Map<String, Map<String, int>> json = {'Cart': user.value.cart};
    _userRepository.updateSingleField(json);
  }

  /// Function to logout
  Future<void> logout() async {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure?',
      onConfirm: () async {
        final auth = AuthenticationRepository.instance;
        await auth.logout();
        html.window.location.reload();
      },
      onCancel: () => () => Get.back(),
    );
  }

  /// Function to delete user account
  Future<void> deleteAccount() async {
    Get.defaultDialog(
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account? This action cannot be undone.',
      onConfirm: () async {
        try {
          // First delete user data from Firestore
          await _userRepository.deleteUserRecord(user.value.id);

          // Then delete the authentication account
          await _authRepository.deleteUserAccount();

          // Reload the page to reset the app state
          html.window.location.reload();
        } catch (e) {
          // Show error message if deletion fails
          Get.back();
          Get.defaultDialog(
            title: 'Error',
            middleText: 'Failed to delete account. You may need to login again before deleting your account.',
            onConfirm: () => Get.back(),
          );
        }
      },
      onCancel: () => Get.back(),
    );
  }

  /// Add item to the cart
  void addToCart(ProductModel product) {
    if (product.stock < 1) {
      return;
    }
    user.value.cart[product.id] = productQuantityInCart.value;
    updateCart();
  }

  /// Update Cart Values
  void updateCart() {
    updateCartTotals();
    updateUserCart();
    user.refresh();
  }

  /// Method to update all cart totals
  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculatedNoOfItems = 0;
    List<ProductModel> products = ProductController.instance.getProductsById(user.value.cart.keys.toList());

    for (var product in products) {
      calculateTotalPrice += product.price * user.value.cart[product.id]!;
      calculatedNoOfItems += user.value.cart[product.id]!;
    }

    totalCartPrice.value = calculateTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  /// Method to get Product Quantity In Cart
  int getProductQuantityInCart(String productId) {
    return user.value.cart[productId] ?? 0;
  }

  /// Method to clear Cart
  void clearCart() {
    productQuantityInCart.value = 0;
    user.value.cart.clear();
    updateCart();
  }

  /// Method to add One Item to Cart
  void addOneToCart(String id) {
    user.value.cart[id] = (user.value.cart[id] ?? 0) + 1;

    updateCart();
  }

  /// Method to remove One Item from Cart
  void removeOneFromCart(String id) {
    if (user.value.cart[id] != null) {
      if ((user.value.cart[id] ?? 0) > 1) {
        user.value.cart[id] = user.value.cart[id]! - 1;
      } else {
        user.value.cart[id] == 1 ? removeFromCartDialog(id) : user.value.cart.remove(id);
      }
      updateCart();
    }
  }

  /// Method to call a dialog
  void removeFromCartDialog(String id) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        user.value.cart.remove(id);
        updateCart();
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  /// Initialize already added Item`s count in the Cart
  void updateAlreadyAddedProductCount(ProductModel product) {
    productQuantityInCart.value = getProductQuantityInCart(product.id);
  }

  /// Method to check if current product is favourite
  bool isFavourite(String productId) {
    return user.value.favorites.contains(productId);
  }

  /// Method to toggle Product
  void toggleFavouriteProduct(String productId) {
    if (!user.value.favorites.contains(productId)) {
      user.value.favorites.add(productId);
      updateUserFavorites();
    } else {
      user.value.favorites.remove(productId);
      updateUserFavorites();
    }
    user.refresh();
  }

  /// Method to get all favorite Products
  Future<List<ProductModel>> favoriteProducts() async {
    return ProductController.instance.getProductsById(user.value.favorites);
  }
}
