import 'package:acquirer/bindings/network_manager.dart';
import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';

/// Class with contloller for
class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  ///Variables
  final userController = Get.put(UserController());

  ///Method to SignIn with Google
  Future<void> googleSignIn() async {
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      return;
    }

    userController.button.value = true;
    final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();
    await userController.saveUserRecord(userCredentials);
  }
}
